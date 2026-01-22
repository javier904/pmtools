import 'package:flutter_test/flutter_test.dart';
import 'package:agile_tools/models/planning_poker_session_model.dart';
import 'package:agile_tools/models/planning_poker_participant_model.dart';
import 'package:agile_tools/models/estimation_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Mock DocumentSnapshot if needed, or just test logic not depending on it for now.
// For fromFirestore, we might need a way to mock. 
// But let's verify logic on the model methods first, which is the core goal.

void main() {
  group('Planning Poker Permissions Tests', () {
    final now = DateTime.now();
    
    // Helper to create a basic session
    PlanningPokerSessionModel createSession({
      String createdBy = 'creator@test.com',
      Map<String, PlanningPokerParticipantModel>? participants,
    }) {
      return PlanningPokerSessionModel(
        id: 'session_123',
        name: 'Test Session',
        createdBy: createdBy,
        createdAt: now,
        updatedAt: now,
        status: PlanningPokerSessionStatus.active,
        cardSet: PlanningPokerCardSet.fibonacci,
        participants: participants ?? {},
        estimationMode: EstimationMode.fibonacci,
      );
    }

    test('isFacilitator returns true for explicitly assigned facilitator', () {
      final session = createSession(
        createdBy: 'creator@test.com',
        participants: {
          'fac@test.com': PlanningPokerParticipantModel(
            email: 'fac@test.com',
            name: 'Facilitator',
            role: ParticipantRole.facilitator,
            joinedAt: now,
            isOnline: true,
          ),
        },
      );
      expect(session.isFacilitator('fac@test.com'), isTrue);
    });

    // TODO: Decide if creator is seemingly facilitator. 
    // Currently implementation relies on map lookup.
    // Use case: Creator creates session. Are they added to map? 
    // Usually yes, at creation time.
    // If not, should `isFacilitator` fallback to `createdBy`?
    // Let's assume for strictness we want them in the map, OR we update logic.
    // Implementation Plan Step 2 says "Update helper methods: isFacilitator (check if user is creator OR has facilitator role)".
    // So we SHOULD update it.
    test('isFacilitator returns true for creator', () {
       final session = createSession(createdBy: 'creator@test.com', participants: {});
       // This will FAIL currently, which is what we want (TDD). 
       // We will then update the model to fix it.
       expect(session.isFacilitator('creator@test.com'), isTrue);
    });

    test('isFacilitator returns false for voter', () {
      final session = createSession(
        createdBy: 'creator@test.com',
        participants: {
          'voter@test.com': PlanningPokerParticipantModel(
            email: 'voter@test.com',
            name: 'Voter',
            role: ParticipantRole.voter,
            joinedAt: now,
            isOnline: true,
          ),
        },
      );
      expect(session.isFacilitator('voter@test.com'), isFalse);
    });

    test('canVote returns true for voter', () {
      final session = createSession(
        createdBy: 'creator@test.com',
        participants: {
          'voter@test.com': PlanningPokerParticipantModel(
            email: 'voter@test.com',
            name: 'Voter',
            role: ParticipantRole.voter,
            joinedAt: now,
            isOnline: true,
          ),
        },
      );
      expect(session.canVote('voter@test.com'), isTrue);
    });

    test('canVote returns true for facilitator', () {
       final session = createSession(
        createdBy: 'creator@test.com',
        participants: {
          'fac@test.com': PlanningPokerParticipantModel(
            email: 'fac@test.com',
            name: 'Facilitator',
            role: ParticipantRole.facilitator,
            joinedAt: now,
            isOnline: true,
          ),
        },
      );
      // Current implementation allows facilitator to vote
      expect(session.canVote('fac@test.com'), isTrue);
    });

    test('canVote returns false for observer', () {
       final session = createSession(
        createdBy: 'creator@test.com',
        participants: {
          'obs@test.com': PlanningPokerParticipantModel(
            email: 'obs@test.com',
            name: 'Observer',
            role: ParticipantRole.observer,
            joinedAt: now,
            isOnline: true,
          ),
        },
      );
      expect(session.canVote('obs@test.com'), isFalse);
    });

    test('Email lookup handles special characters if they are keys in map', () {
      // In-memory model uses standard emails as keys (unescaping happens at boundary)
      final session = createSession(participants: {
        'test.user@email.com': PlanningPokerParticipantModel(
           email: 'test.user@email.com',
           name: 'Test',
           role: ParticipantRole.voter,
           joinedAt: now,
           isOnline: true,
        )
      });
      
      expect(session.canVote('test.user@email.com'), isTrue);
      expect(session.canVote('wrong@email.com'), isFalse);
    });
  });
}
