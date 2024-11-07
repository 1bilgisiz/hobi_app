import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Data/Auth/AuthServices.dart';

class LoginViewModel with ChangeNotifier {
  String _email = "";
  String _password = "";
  bool _obscurePasswordText = true;
  final AuthServices _authServices = AuthServices();

  //MARK: GETTERS
  bool get obscurePasswordText => _obscurePasswordText;

  //MARK: SETTERS
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setPasswordObsureText(bool obscurePasswordText) {
    _obscurePasswordText = obscurePasswordText;
    notifyListeners();
  }

  //MARK: VALIDATORS
  String? validateEmail(String? email) {
    if (!EmailValidator.validate(email ?? "")) {
      return "Lütfen gerçek bir emeail adresi giriniz";
    }
    if (email == "") {
      return "Lütfen email alanını doldurnuz";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password == "") {
      return "Lütfen şifre alanını doldurunuz";
    }
    return null;
  }

  String? _areInputsvalid() {
    final isEmailValid = validateEmail(_email);
    if (isEmailValid != null) {
      return isEmailValid;
    }

    final isPasswordValid = validatePassword(_password);
    if (isPasswordValid != null) {
      return isPasswordValid;
    }

    return null;
  }

  //MARK: LOGIN
  Future<String?> login(SplashViewModel splashVM) async {
    // STEP: check if inputs are valid
    final isValidInput = _areInputsvalid();
    if (isValidInput != null) {
      return isValidInput;
    }

    //STEP: login
    final response =
        await _authServices.signwithEmailandPassword(_email, _password);
    if (response.success) {
      splashVM.setUser(response.hobiUser!);
      return null;
    }

    return response.code;
  }

  Map<String, String> getErrorMessage = {
    "invalid-credential": "Lütfen giriş bilgilerini kontrol ediniz."
  };
}
