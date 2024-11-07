import 'package:firebase_auth/firebase_auth.dart';
import 'package:hobiapp/Model/HobiUser.dart';

class AuthResponse {
  final bool success;
  final String? code;
  final User? user;
  final HobiUser? hobiUser;

  AuthResponse({
    required this.success,
    required this.code,
    required this.user,
    required this.hobiUser,
  });

  factory AuthResponse.withError() {
    return AuthResponse(
      success: false,
      code: "An unexpected error has occurred, please try again",
      user: null,
      hobiUser: null,
    );
  }
}
