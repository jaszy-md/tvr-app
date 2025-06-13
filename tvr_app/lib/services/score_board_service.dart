import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreboardService {
  final CollectionReference _participants = FirebaseFirestore.instance
      .collection('participants');

  Future<List<Map<String, dynamic>>> fetchParticipants() async {
    final snapshot = await _participants.get();
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'name': doc['name'],
        'email': doc['email'],
        'score_position': doc['score_position'] ?? 0,
      };
    }).toList();
  }

  /// Zet bij het openen van de pagina alle score_position op 0
  Future<void> resetAllPositions() async {
    final snapshot = await _participants.get();
    for (var doc in snapshot.docs) {
      await doc.reference.set({'score_position': 0}, SetOptions(merge: true));
    }
  }

  /// Kies bij klik op knop willekeurig 3 winnaars
  Future<void> shuffleWinners() async {
    final snapshot = await _participants.get();
    final docs = snapshot.docs;

    if (docs.length < 3) return;

    final shuffled = [...docs]..shuffle(Random());

    for (int i = 0; i < docs.length; i++) {
      final score = (i < 3) ? i + 1 : 0;
      await shuffled[i].reference.set({
        'score_position': score,
      }, SetOptions(merge: true));
    }
  }
}
