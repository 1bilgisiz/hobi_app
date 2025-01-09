import 'package:hobiapp/Model/Auth/AuthResponse.dart';
import 'package:hobiapp/Model/Auth/Request/CreateUserRequest.dart';

abstract class AuthBase {
  Future<AuthResponse> currentUser();
  Future<bool> signOut();
  Future<AuthResponse> signwithEmailandPassword(String email, String password);
  Future<AuthResponse> createAccount({
    required CreateUserRequest createUserRequest,
  });
  Future<bool> resetPassword({required String email});
}
