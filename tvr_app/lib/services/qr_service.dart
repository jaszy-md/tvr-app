import 'package:cloud_firestore/cloud_firestore.dart';

class QRService {
  final CollectionReference _participants = FirebaseFirestore.instance
      .collection('participants');

  Future<bool> emailExists(String email) async {
    final query =
        await _participants.where('email', isEqualTo: email).limit(1).get();
    return query.docs.isNotEmpty;
  }

  Future<void> addParticipant(String name, String email) async {
    final alreadyExists = await emailExists(email);
    if (alreadyExists) {
      throw Exception('E-mailadres is al geregistreerd.');
    }

    await _participants.add({
      'name': name,
      'email': email,
      'timestamp': FieldValue.serverTimestamp(),
      'score_position': 0,
    });
  }
}
