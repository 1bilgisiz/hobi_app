import 'package:flutter/material.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Data/Auth/AuthServices.dart';
import 'package:hobiapp/Data/Home/HomeServices.dart';
import 'package:hobiapp/Model/HobiUser.dart';

class HomeViewModel with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  final HomeServices _homeServices = HomeServices();
  String _hobby = "";

  //MARK: SETTERS
  void setHobby(String hobby) {
    _hobby = hobby;
    notifyListeners();
  }

  //MARK: VALIDATORS
  String? validateHobby(String? hobby) {
    if (hobby == null || hobby == "") {
      return "Lütfen hobi alanını doldurunuz";
    }
    return null;
  }

  //MARK: LOGOUT
  Future<bool> logout(SplashViewModel splashVM) async {
    try {
      final response = await _authServices.signOut();
      if (response) {
        splashVM.setUser(HobiUser.withDefault());
      }
      return response;
    } catch (e) {
      return false;
    }
  }

  //MARK: RESET
  void reset() {
    _hobby = "";
    notifyListeners();
  }

  //MARK: ADD HOBBY
  Future<String?> addHobby(SplashViewModel splashVM) async {
    List<String> hobbies = splashVM.user.hobbies;
    hobbies.add(_hobby);
    final response =
        await _homeServices.addHobby(hobbies: hobbies, id: splashVM.user.id);
    if (response) {
      reset();
      return null;
    }
    return "Bir hata oluştu";
  }
}
