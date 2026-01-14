import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Servizio di autenticazione semplificato per Agile Tools
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/gmail.send', // Per invio email inviti
      'https://www.googleapis.com/auth/spreadsheets', // Per export Sheets
      'https://www.googleapis.com/auth/drive.file', // Per creare file Drive
    ],
  );

  /// Token OAuth per Web (memorizzato dal login Firebase)
  String? _webAccessToken;

  /// Accesso a GoogleSignIn per Gmail API
  GoogleSignIn get googleSignIn => _googleSignIn;

  /// Token OAuth per chiamate API (su web, da Firebase Auth)
  String? get webAccessToken => _webAccessToken;

  /// Utente corrente
  User? get currentUser => _auth.currentUser;

  /// Stream dello stato di autenticazione
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Email utente corrente
  String? get currentUserEmail => currentUser?.email;

  /// Nome utente corrente
  String? get currentUserName => currentUser?.displayName;

  /// Foto utente corrente
  String? get currentUserPhoto => currentUser?.photoURL;

  /// Verifica se l'utente è autenticato
  bool get isAuthenticated => currentUser != null;

  /// Login con Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web: usa popup con tutti gli scope necessari
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');
        googleProvider.addScope('https://www.googleapis.com/auth/gmail.send'); // Per invio email
        googleProvider.addScope('https://www.googleapis.com/auth/spreadsheets'); // Per export Sheets
        googleProvider.addScope('https://www.googleapis.com/auth/drive.file'); // Per creare file Drive

        final userCredential = await _auth.signInWithPopup(googleProvider);

        // Estrai e memorizza l'access token OAuth per le API
        final oauthCredential = userCredential.credential as OAuthCredential?;
        if (oauthCredential != null) {
          _webAccessToken = oauthCredential.accessToken;
          print('✅ [AUTH] Access token OAuth memorizzato per le API');
          print('✅ [AUTH] Token presente: ${_webAccessToken != null}');
        } else {
          print('⚠️ [AUTH] Nessun credential OAuth disponibile');
        }

        return userCredential;
      } else {
        // Mobile: usa il flusso nativo
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null;

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('❌ Errore login Google: $e');
      rethrow;
    }
  }

  /// Richiede un nuovo access token OAuth per le API (su web)
  /// Utile se il token è scaduto
  Future<String?> refreshWebAccessToken() async {
    if (!kIsWeb) return null;

    try {
      // Su web, dobbiamo fare un re-auth per ottenere un nuovo token
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('email');
      googleProvider.addScope('profile');
      googleProvider.addScope('https://www.googleapis.com/auth/gmail.send');
      googleProvider.addScope('https://www.googleapis.com/auth/spreadsheets');
      googleProvider.addScope('https://www.googleapis.com/auth/drive.file');

      final userCredential = await _auth.signInWithPopup(googleProvider);
      final oauthCredential = userCredential.credential as OAuthCredential?;

      if (oauthCredential != null) {
        _webAccessToken = oauthCredential.accessToken;
        print('✅ [AUTH] Access token OAuth aggiornato');
        return _webAccessToken;
      }
      return null;
    } catch (e) {
      print('❌ [AUTH] Errore refresh token: $e');
      return null;
    }
  }

  /// Login con Email/Password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('❌ Errore login email: $e');
      rethrow;
    }
  }

  /// Registrazione con Email/Password
  Future<UserCredential?> registerWithEmail(String email, String password, String displayName) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Aggiorna il display name
      await credential.user?.updateDisplayName(displayName);

      return credential;
    } catch (e) {
      print('❌ Errore registrazione: $e');
      rethrow;
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('❌ Errore reset password: $e');
      rethrow;
    }
  }

  /// Logout
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('❌ Errore logout: $e');
      rethrow;
    }
  }
}
