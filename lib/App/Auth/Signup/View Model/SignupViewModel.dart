import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Data/Auth/AuthServices.dart';
import 'package:hobiapp/Model/Auth/Request/CreateUserRequest.dart';

class SignupViewModel with ChangeNotifier {
  String _name = "",
      _surname = "",
      _email = "",
      _biography = "",
      _password = "",
      _confirmPassword = "";
  DateTime? _birthOfDate;
  bool _obscurePasswordText = true, _obscureConfirmPasswordText = true;

  //MARK: GETTERS
  bool get obscurePasswordText => _obscurePasswordText;
  bool get obscureConfirmPasswordText => _obscureConfirmPasswordText;
  DateTime? get birthOfDate => _birthOfDate;
  final AuthServices _authServices = AuthServices();

  //MARK: SETTERS
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setSurname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setBiograpy(String biography) {
    _biography = biography;
    notifyListeners();
  }

  void setBirthOfDate(DateTime birthOfDate) {
    _birthOfDate = birthOfDate;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setPasswordObsureText(bool obscurePasswordText) {
    _obscurePasswordText = obscurePasswordText;
    notifyListeners();
  }

  void setConfirmPasswordObsureText(bool obscureConfirmPasswordText) {
    _obscureConfirmPasswordText = obscureConfirmPasswordText;
    notifyListeners();
  }

  //VALIDATORS
  String? validateName(String? name) {
    if (name == null || name == "") {
      return "Lütfen ad alanını doldurunuz";
    }
    return null;
  }

  String? validateSurname(String? surname) {
    if (surname == null || surname == "") {
      return "Lütfen soyad alanını doldurunuz";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (!EmailValidator.validate(email ?? "")) {
      return "Lütfen gerçek bir emeail adresi giriniz";
    }
    if (email == "") {
      return "Lütfen email alanını doldurnuz";
    }
    return null;
  }

  String? validateBiography(String? biography) {
    if (biography == null || biography == "") {
      return "Lütfen biyografi alanını doldurunuz";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password == "") {
      return "Lütfen şifre alanını doldurunuz";
    }
    return null;
  }

  String? validateConfirmPassword(String? password) {
    if (password == null || password == "") {
      return "Lütfen şifre alanını doldurunuz";
    }
    return null;
  }

  String? validatePasswords(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return "Şifreler eşleşmiyor. Lütfen şifreleri kontrol ediniz";
    }
    return null;
  }

  String? _areInputsvalid() {
    final isNameValid = validateName(_name);
    if (isNameValid != null) {
      return isNameValid;
    }

    final isSurnameValid = validateSurname(_surname);
    if (isSurnameValid != null) {
      return isSurnameValid;
    }

    final isEmailValid = validateEmail(_email);
    if (isEmailValid != null) {
      return isEmailValid;
    }

    final isBiographyValid = validateBiography(_biography);
    if (isBiographyValid != null) {
      return isBiographyValid;
    }

    final isBirthOfDateValid =
        _birthOfDate == null ? "Lütfen doğum tarihini seçiniz" : null;
    if (isBirthOfDateValid != null) {
      return isBirthOfDateValid;
    }

    final isPasswordValid = validatePassword(_password);
    if (isPasswordValid != null) {
      return isPasswordValid;
    }

    final isConfirmPasswordValid = validateConfirmPassword(_confirmPassword);
    if (isConfirmPasswordValid != null) {
      return isConfirmPasswordValid;
    }

    final isValidatePasswords = validatePasswords(_password, _confirmPassword);
    if (isValidatePasswords != null) {
      return isValidatePasswords;
    }
    return null;
  }

  //MARK: GET USER INFORMATIONS
  CreateUserRequest getCreateUserRequest() {
    return CreateUserRequest(
      id: '',
      name: _name,
      surname: _surname,
      email: _email,
      password: _password,
      birthOfDate: _birthOfDate!,
      biography: _biography,
    );
  }

  //MARK: RESET
  void reset() {
    _name = "";
    _surname = "";
    _email = "";
    _biography = "";
    _password = "";
    _confirmPassword = "";
    _birthOfDate = null;
    _obscurePasswordText = true;
    _obscureConfirmPasswordText = true;
    notifyListeners();
  }

  //MARK: CREATE ACCOUNT
  Future<String?> createAccount(SplashViewModel splashVM) async {
    // STEP: check if inputs are valid
    final isValidInput = _areInputsvalid();
    if (isValidInput != null) {
      return isValidInput;
    }

    //STEP: get create user informations
    final createUserRequest = getCreateUserRequest();

    //STEP: create user
    final response =
        await _authServices.createAccount(createUserRequest: createUserRequest);

    if (response.success) {
      //STEP: reset values
      reset();
      splashVM.setUser(response.hobiUser!);
      return null;
    }

    return getErrorMessage[response.code];
  }

  Map<String, String> getErrorMessage = {
    "email-already-in-use":
        "Bu email kullanılmaktadır başka bir email ile deneyiniz.",
    "weak-password": "Şifre güçlü değil, şifre uzunluğu en az 6 olmalıdır."
  };
}
