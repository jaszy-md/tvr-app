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

  Future<void> resetAllPositions() async {
    final snapshot = await _participants.get();
    for (var doc in snapshot.docs) {
      await doc.reference.set({'score_position': 0}, SetOptions(merge: true));
    }
  }

  Future<void> shuffleWinners() async {
    final snapshot = await _participants.get();
    final docs = snapshot.docs;

    if (docs.length < 3) return;

    final shuffled = [...docs]..shuffle(Random());
    final top3 = shuffled.take(3).toList();
    final rest = shuffled.skip(3);

    await top3[0].reference.set({'score_position': 1}, SetOptions(merge: true));
    await top3[1].reference.set({'score_position': 2}, SetOptions(merge: true));
    await top3[2].reference.set({'score_position': 3}, SetOptions(merge: true));

    await Future.wait(
      rest.map(
        (doc) =>
            doc.reference.set({'score_position': 0}, SetOptions(merge: true)),
      ),
    );
  }
}
