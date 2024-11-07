import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hobiapp/Model/Auth/AuthBase.dart';
import 'package:hobiapp/Model/Auth/AuthResponse.dart';
import 'package:hobiapp/Model/Auth/Request/CreateUserRequest.dart';
import 'package:hobiapp/Model/HobiUser.dart';

class AuthServices implements AuthBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<AuthResponse> createAccount(
      {required CreateUserRequest createUserRequest}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );

      CollectionReference ref = _firestore.collection('users');
      createUserRequest.id = userCredential.user!.uid;
      ref.add(createUserRequest.toJson());
      final userData = await _firestore
          .collection("users")
          .where('id', isEqualTo: userCredential.user!.uid)
          .get();

      final hobiUser = HobiUser.fromJson(userData.docs.first.data());

      return AuthResponse(
        success: true,
        code: null,
        user: userCredential.user!,
        hobiUser: hobiUser,
      );
    } on FirebaseAuthException catch (e) {
      return AuthResponse(
          success: false, code: e.code, user: null, hobiUser: null);
    }
  }

  @override
  Future<AuthResponse> currentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        final userData = await _firestore
            .collection("users")
            .where('id', isEqualTo: user.uid)
            .get();

        final hobiUser = HobiUser.fromJson(userData.docs.first.data());

        return AuthResponse(
          success: true,
          code: null,
          user: user,
          hobiUser: hobiUser,
        );
      } else {
        return AuthResponse(
            success: false,
            code: "User mevcut değil",
            user: null,
            hobiUser: null);
      }
    } on FirebaseAuthException catch (e) {
      return AuthResponse(
          success: false, code: e.code, user: null, hobiUser: null);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthResponse> signwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        final userData = await _firestore
            .collection("users")
            .where('id', isEqualTo: user.user!.uid)
            .get();

        final hobiUser = HobiUser.fromJson(userData.docs.first.data());

        return AuthResponse(
          success: true,
          code: null,
          user: user.user,
          hobiUser: hobiUser,
        );
      } else {
        return AuthResponse(
            success: false,
            code: "User mevcut değil",
            user: null,
            hobiUser: null);
      }
    } on FirebaseAuthException catch (e) {
      return AuthResponse(
          success: false, code: e.code, user: null, hobiUser: null);
    }
  }
}
