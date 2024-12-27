import 'package:cloud_firestore/cloud_firestore.dart';

class HomeServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addHobby({
    required List<String> hobbies,
    required String id,
  }) async {
    try {
      final userData =
          await _firestore.collection("users").where('id', isEqualTo: id).get();

      DocumentSnapshot userDoc = userData.docs.first;
      if (userDoc.exists) {
        await _firestore
            .collection("users")
            .doc(userDoc.id)
            .update({'hobbies': hobbies});
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
