import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobiapp/Data/Settings/Request/UserUpdateRequest.dart';

class SettingsServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> updateSettings({
    required String id,
    required UserUpdateRequest userSettigs,
  }) async {
    try {
      final userData =
          await _firestore.collection("users").where('id', isEqualTo: id).get();
      DocumentSnapshot userDoc = userData.docs.first;
      if (userDoc.exists) {
        await _firestore
            .collection("users")
            .doc(userDoc.id)
            .update(userSettigs.toJson());

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
