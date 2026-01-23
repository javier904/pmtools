/**
 * Cloud Functions per Agile Tools - Gestione Abbonamenti Stripe
 *
 * Funzioni disponibili:
 * - stripeWebhook: Handler per eventi Stripe (subscription.*, invoice.*, customer.*)
 * - createPortalSession: Crea sessione per Stripe Billing Portal
 * - syncSubscriptionStatus: Sincronizza stato subscription con app
 * - handleTrialExpiration: Notifiche scadenza trial
 *
 * Questo modulo e' progettato per funzionare con Firebase Extension "Run Payments with Stripe"
 * e sincronizza i dati subscription nella collection users/{userId}/subscription/current
 */

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import Stripe from 'stripe';

// Inizializza Firebase Admin
admin.initializeApp();

const db = admin.firestore();

// Inizializza Stripe con la secret key da Firebase config
const stripeSecretKey = functions.config().stripe?.secret_key || process.env.STRIPE_SECRET_KEY;
const stripeWebhookSecret = functions.config().stripe?.webhook_secret || process.env.STRIPE_WEBHOOK_SECRET;

let stripe: Stripe | null = null;
if (stripeSecretKey) {
  stripe = new Stripe(stripeSecretKey, {
    apiVersion: '2023-10-16',
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// CONFIGURAZIONE PRODOTTI
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Mapping tra price ID Stripe e piano dell'app
 * Configurare con i veri price ID dal Stripe Dashboard
 */
const PRICE_TO_PLAN: Record<string, string> = {
  // Premium
  'price_premium_monthly': 'premium',
  'price_premium_yearly': 'premium',
  // Elite
  'price_elite_monthly': 'elite',
  'price_elite_yearly': 'elite',
};

/**
 * Mapping tra status Stripe e status interno
 */
const STATUS_MAPPING: Record<string, string> = {
  'active': 'active',
  'trialing': 'active',
  'past_due': 'past_due',
  'canceled': 'canceled',
  'unpaid': 'suspended',
  'incomplete': 'pending',
  'incomplete_expired': 'expired',
};

// ═══════════════════════════════════════════════════════════════════════════════
// WEBHOOK STRIPE
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Handler per webhook Stripe
 *
 * Eventi gestiti:
 * - customer.subscription.created
 * - customer.subscription.updated
 * - customer.subscription.deleted
 * - invoice.payment_succeeded
 * - invoice.payment_failed
 * - customer.subscription.trial_will_end
 */
export const stripeWebhook = functions.https.onRequest(async (req, res) => {
  if (!stripe || !stripeWebhookSecret) {
    console.error('Stripe not configured');
    res.status(500).send('Stripe not configured');
    return;
  }

  const sig = req.headers['stripe-signature'] as string;

  let event: Stripe.Event;

  try {
    event = stripe.webhooks.constructEvent(req.rawBody, sig, stripeWebhookSecret);
  } catch (err) {
    console.error('Webhook signature verification failed:', err);
    res.status(400).send(`Webhook Error: ${(err as Error).message}`);
    return;
  }

  console.log(`📩 Stripe event received: ${event.type}`);

  try {
    switch (event.type) {
      case 'customer.subscription.created':
      case 'customer.subscription.updated':
        await handleSubscriptionChange(event.data.object as Stripe.Subscription);
        break;

      case 'customer.subscription.deleted':
        await handleSubscriptionDeleted(event.data.object as Stripe.Subscription);
        break;

      case 'invoice.payment_succeeded':
        await handlePaymentSucceeded(event.data.object as Stripe.Invoice);
        break;

      case 'invoice.payment_failed':
        await handlePaymentFailed(event.data.object as Stripe.Invoice);
        break;

      case 'customer.subscription.trial_will_end':
        await handleTrialWillEnd(event.data.object as Stripe.Subscription);
        break;

      default:
        console.log(`Unhandled event type: ${event.type}`);
    }

    res.json({ received: true });
  } catch (error) {
    console.error('Error handling webhook:', error);
    res.status(500).send('Internal error');
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// HANDLER EVENTI
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Gestisce creazione/aggiornamento subscription
 */
async function handleSubscriptionChange(subscription: Stripe.Subscription): Promise<void> {
  console.log(`📝 Handling subscription change: ${subscription.id}`);

  const userId = await getUserIdFromCustomer(subscription.customer as string);
  if (!userId) {
    console.error('User not found for customer:', subscription.customer);
    return;
  }

  const priceId = subscription.items.data[0]?.price.id;
  const plan = PRICE_TO_PLAN[priceId] || 'free';
  const status = STATUS_MAPPING[subscription.status] || subscription.status;

  const subscriptionData = {
    plan: plan,
    status: status,
    externalSubscriptionId: subscription.id,
    externalCustomerId: subscription.customer as string,
    startDate: admin.firestore.Timestamp.fromMillis(subscription.current_period_start * 1000),
    endDate: admin.firestore.Timestamp.fromMillis(subscription.current_period_end * 1000),
    trialEndDate: subscription.trial_end
      ? admin.firestore.Timestamp.fromMillis(subscription.trial_end * 1000)
      : null,
    cancelAtPeriodEnd: subscription.cancel_at_period_end,
    canceledAt: subscription.canceled_at
      ? admin.firestore.Timestamp.fromMillis(subscription.canceled_at * 1000)
      : null,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  // Salva in users/{userId}/subscription/current
  await db
    .collection('users')
    .doc(userId)
    .collection('subscription')
    .doc('current')
    .set(subscriptionData, { merge: true });

  // Aggiunge alla history
  await db
    .collection('users')
    .doc(userId)
    .collection('subscription_history')
    .add({
      ...subscriptionData,
      eventType: 'subscription_change',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

  console.log(`✅ Subscription updated for user: ${userId}`);
}

/**
 * Gestisce cancellazione subscription
 */
async function handleSubscriptionDeleted(subscription: Stripe.Subscription): Promise<void> {
  console.log(`🗑️ Handling subscription deleted: ${subscription.id}`);

  const userId = await getUserIdFromCustomer(subscription.customer as string);
  if (!userId) {
    console.error('User not found for customer:', subscription.customer);
    return;
  }

  // Imposta plan a free
  const subscriptionData = {
    plan: 'free',
    status: 'canceled',
    externalSubscriptionId: subscription.id,
    canceledAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  await db
    .collection('users')
    .doc(userId)
    .collection('subscription')
    .doc('current')
    .set(subscriptionData, { merge: true });

  // Aggiunge alla history
  await db
    .collection('users')
    .doc(userId)
    .collection('subscription_history')
    .add({
      ...subscriptionData,
      eventType: 'subscription_deleted',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

  console.log(`✅ Subscription canceled for user: ${userId}`);
}

/**
 * Gestisce pagamento riuscito
 */
async function handlePaymentSucceeded(invoice: Stripe.Invoice): Promise<void> {
  if (!invoice.subscription) return;

  console.log(`💰 Payment succeeded for subscription: ${invoice.subscription}`);

  const userId = await getUserIdFromCustomer(invoice.customer as string);
  if (!userId) return;

  // Salva record pagamento
  await db
    .collection('users')
    .doc(userId)
    .collection('payments')
    .add({
      invoiceId: invoice.id,
      subscriptionId: invoice.subscription,
      amount: invoice.amount_paid,
      currency: invoice.currency,
      status: 'succeeded',
      paidAt: admin.firestore.Timestamp.fromMillis(invoice.status_transitions.paid_at! * 1000),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

  console.log(`✅ Payment recorded for user: ${userId}`);
}

/**
 * Gestisce pagamento fallito
 */
async function handlePaymentFailed(invoice: Stripe.Invoice): Promise<void> {
  if (!invoice.subscription) return;

  console.log(`❌ Payment failed for subscription: ${invoice.subscription}`);

  const userId = await getUserIdFromCustomer(invoice.customer as string);
  if (!userId) return;

  // Aggiorna status subscription
  await db
    .collection('users')
    .doc(userId)
    .collection('subscription')
    .doc('current')
    .update({
      status: 'past_due',
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

  // Salva record pagamento fallito
  await db
    .collection('users')
    .doc(userId)
    .collection('payments')
    .add({
      invoiceId: invoice.id,
      subscriptionId: invoice.subscription,
      amount: invoice.amount_due,
      currency: invoice.currency,
      status: 'failed',
      failureReason: invoice.last_finalization_error?.message || 'Unknown',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

  // TODO: Inviare notifica email all'utente

  console.log(`⚠️ Payment failure recorded for user: ${userId}`);
}

/**
 * Gestisce notifica scadenza trial
 */
async function handleTrialWillEnd(subscription: Stripe.Subscription): Promise<void> {
  console.log(`⏰ Trial ending soon for subscription: ${subscription.id}`);

  const userId = await getUserIdFromCustomer(subscription.customer as string);
  if (!userId) return;

  // Salva notifica per l'utente
  await db
    .collection('users')
    .doc(userId)
    .collection('notifications')
    .add({
      type: 'trial_ending',
      title: 'Il tuo periodo di prova sta per terminare',
      body: 'Il tuo periodo di prova terminerà tra 3 giorni. Aggiorna il metodo di pagamento per continuare.',
      subscriptionId: subscription.id,
      trialEndDate: admin.firestore.Timestamp.fromMillis(subscription.trial_end! * 1000),
      read: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

  console.log(`✅ Trial ending notification created for user: ${userId}`);
}

// ═══════════════════════════════════════════════════════════════════════════════
// PORTAL SESSION
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Crea una sessione per il Stripe Billing Portal
 *
 * L'utente puo' gestire:
 * - Metodo di pagamento
 * - Cancellazione abbonamento
 * - Storico fatture
 */
export const createPortalSession = functions.https.onCall(async (data, context) => {
  if (!stripe) {
    throw new functions.https.HttpsError('unavailable', 'Stripe not configured');
  }

  // Verifica autenticazione
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const userId = context.auth.uid;
  const returnUrl = data.returnUrl || 'https://pm-agile-tools-app.web.app/#/subscription';

  try {
    // Ottieni customer ID dall'utente
    const customerId = await getCustomerIdFromUser(userId);
    if (!customerId) {
      throw new functions.https.HttpsError('not-found', 'No Stripe customer found for user');
    }

    // Crea sessione portal
    const session = await stripe.billingPortal.sessions.create({
      customer: customerId,
      return_url: returnUrl,
    });

    return { url: session.url };
  } catch (error) {
    console.error('Error creating portal session:', error);
    throw new functions.https.HttpsError('internal', 'Failed to create portal session');
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// SYNC SUBSCRIPTION
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Sincronizza manualmente lo stato subscription da Stripe
 *
 * Utile per recovery dopo problemi di webhook
 */
export const syncSubscriptionStatus = functions.https.onCall(async (data, context) => {
  if (!stripe) {
    throw new functions.https.HttpsError('unavailable', 'Stripe not configured');
  }

  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const userId = context.auth.uid;

  try {
    const customerId = await getCustomerIdFromUser(userId);
    if (!customerId) {
      // Nessun customer, imposta free
      await db
        .collection('users')
        .doc(userId)
        .collection('subscription')
        .doc('current')
        .set({
          plan: 'free',
          status: 'active',
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      return { success: true, plan: 'free' };
    }

    // Ottieni subscriptions attive
    const subscriptions = await stripe.subscriptions.list({
      customer: customerId,
      status: 'active',
      limit: 1,
    });

    if (subscriptions.data.length === 0) {
      // Nessuna subscription attiva
      await db
        .collection('users')
        .doc(userId)
        .collection('subscription')
        .doc('current')
        .set({
          plan: 'free',
          status: 'active',
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      return { success: true, plan: 'free' };
    }

    // Aggiorna con subscription attiva
    const subscription = subscriptions.data[0];
    await handleSubscriptionChange(subscription);

    const priceId = subscription.items.data[0]?.price.id;
    const plan = PRICE_TO_PLAN[priceId] || 'free';

    return { success: true, plan };
  } catch (error) {
    console.error('Error syncing subscription:', error);
    throw new functions.https.HttpsError('internal', 'Failed to sync subscription');
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// UTILITY FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Ottiene l'ID utente Firebase dal customer ID Stripe
 */
async function getUserIdFromCustomer(customerId: string): Promise<string | null> {
  // Prima cerca nella collection stripe_customers (creata dalla Firebase Extension)
  const customersSnapshot = await db
    .collection('stripe_customers')
    .where('stripeId', '==', customerId)
    .limit(1)
    .get();

  if (!customersSnapshot.empty) {
    return customersSnapshot.docs[0].id;
  }

  // Fallback: cerca in users per externalCustomerId
  const usersSnapshot = await db
    .collectionGroup('subscription')
    .where('externalCustomerId', '==', customerId)
    .limit(1)
    .get();

  if (!usersSnapshot.empty) {
    // Il path sarà users/{userId}/subscription/current
    const path = usersSnapshot.docs[0].ref.path;
    const parts = path.split('/');
    return parts[1]; // userId
  }

  return null;
}

/**
 * Ottiene il customer ID Stripe dall'ID utente Firebase
 */
async function getCustomerIdFromUser(userId: string): Promise<string | null> {
  // Prima cerca nella collection stripe_customers
  const customerDoc = await db.collection('stripe_customers').doc(userId).get();

  if (customerDoc.exists) {
    return customerDoc.data()?.stripeId || null;
  }

  // Fallback: cerca in subscription
  const subscriptionDoc = await db
    .collection('users')
    .doc(userId)
    .collection('subscription')
    .doc('current')
    .get();

  if (subscriptionDoc.exists) {
    return subscriptionDoc.data()?.externalCustomerId || null;
  }

  return null;
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATION LIMIT VALIDATION
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Limiti per tier per entity type
 */
const TIER_LIMITS: Record<string, Record<string, number>> = {
  free: {
    estimation: 5,
    eisenhower: 5,
    smart_todo: 5,
    retrospective: 5,
    agile_project: 5,
  },
  premium: {
    estimation: 30,
    eisenhower: 30,
    smart_todo: 30,
    retrospective: 30,
    agile_project: 30,
  },
  elite: {
    estimation: 999999,
    eisenhower: 999999,
    smart_todo: 999999,
    retrospective: 999999,
    agile_project: 999999,
  },
};

/**
 * Collection mapping per entity type
 */
const ENTITY_COLLECTIONS: Record<string, string> = {
  estimation: 'planning_poker_sessions',
  eisenhower: 'eisenhower_matrices',
  smart_todo: 'smart_todo_lists',
  retrospective: 'retrospectives',
  agile_project: 'agile_projects',
};

/**
 * Validates if a user can create a new entity based on subscription limits.
 * Called before document creation as server-side double-check.
 *
 * Input: { entityType: string }
 * Output: { allowed: boolean, currentCount: number, limit: number, tier: string }
 */
export const validateCreationLimit = functions.https.onCall(async (data, context) => {
  // Verifica autenticazione
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { entityType } = data;
  if (!entityType || !ENTITY_COLLECTIONS[entityType]) {
    throw new functions.https.HttpsError('invalid-argument', `Invalid entityType: ${entityType}`);
  }

  const userId = context.auth.uid;
  const userEmail = context.auth.token.email?.toLowerCase() || '';

  try {
    // 1. Leggi tier subscription dell'utente
    const subscriptionDoc = await db
      .collection('users')
      .doc(userId)
      .collection('subscription')
      .doc('current')
      .get();

    const tier = subscriptionDoc.exists
      ? (subscriptionDoc.data()?.plan || 'free')
      : 'free';

    // 2. Calcola limite per tier
    const limits = TIER_LIMITS[tier] || TIER_LIMITS['free'];
    const limit = limits[entityType] || 5;

    // Elite = unlimited
    if (tier === 'elite') {
      return { allowed: true, currentCount: 0, limit: 999999, tier };
    }

    // 3. Conta documenti esistenti (non archiviati) dove l'utente è owner
    const collection = ENTITY_COLLECTIONS[entityType];
    let count = 0;

    if (entityType === 'smart_todo') {
      // Smart Todo usa ownerEmail
      const snapshot = await db
        .collection(collection)
        .where('participantEmails', 'array-contains', userEmail)
        .get();

      count = snapshot.docs.filter(doc => {
        const docData = doc.data();
        const ownerEmail = (docData.ownerEmail || '').toLowerCase();
        const createdBy = (docData.createdBy || '').toLowerCase();
        const isArchived = docData.isArchived || false;
        return !isArchived && (ownerEmail === userEmail || createdBy === userEmail);
      }).length;
    } else {
      // Altri usano createdBy o participantEmails
      const snapshot = await db
        .collection(collection)
        .where('participantEmails', 'array-contains', userEmail)
        .get();

      count = snapshot.docs.filter(doc => {
        const docData = doc.data();
        const createdBy = (docData.createdBy || '').toLowerCase();
        const isArchived = docData.isArchived || false;
        return !isArchived && createdBy === userEmail;
      }).length;
    }

    // 4. Verifica limite
    const allowed = count < limit;

    console.log(`🔒 Limit check: user=${userEmail}, entity=${entityType}, tier=${tier}, count=${count}/${limit}, allowed=${allowed}`);

    return { allowed, currentCount: count, limit, tier };
  } catch (error) {
    console.error('Error validating creation limit:', error);
    throw new functions.https.HttpsError('internal', 'Failed to validate creation limit');
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// SCHEDULED FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Funzione schedulata per verificare trial in scadenza
 * Esegue ogni giorno alle 9:00 UTC
 */
export const checkTrialExpirations = functions.pubsub
  .schedule('0 9 * * *')
  .timeZone('UTC')
  .onRun(async (context) => {
    console.log('🔄 Checking trial expirations...');

    const now = new Date();
    const threeDaysFromNow = new Date(now.getTime() + 3 * 24 * 60 * 60 * 1000);

    // Trova subscription con trial che scade tra 3 giorni
    const subscriptionsSnapshot = await db
      .collectionGroup('subscription')
      .where('status', '==', 'active')
      .where('trialEndDate', '>=', admin.firestore.Timestamp.fromDate(now))
      .where('trialEndDate', '<=', admin.firestore.Timestamp.fromDate(threeDaysFromNow))
      .get();

    console.log(`Found ${subscriptionsSnapshot.size} trials expiring soon`);

    for (const doc of subscriptionsSnapshot.docs) {
      const path = doc.ref.path;
      const parts = path.split('/');
      const userId = parts[1];

      // Verifica che non esista già una notifica recente
      const recentNotification = await db
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('type', '==', 'trial_ending')
        .where('createdAt', '>=', admin.firestore.Timestamp.fromDate(new Date(now.getTime() - 24 * 60 * 60 * 1000)))
        .limit(1)
        .get();

      if (recentNotification.empty) {
        await db
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add({
            type: 'trial_ending',
            title: 'Il tuo periodo di prova sta per terminare',
            body: 'Il tuo periodo di prova terminerà tra 3 giorni. Aggiorna il metodo di pagamento per continuare.',
            trialEndDate: doc.data().trialEndDate,
            read: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });

        console.log(`✅ Trial ending notification sent to user: ${userId}`);
      }
    }

    return null;
  });
