import 'package:flutter/material.dart';
import 'package:hobiapp/Data/Auth/AuthServices.dart';
import 'package:hobiapp/Model/HobiUser.dart';

class SplashViewModel with ChangeNotifier {
  HobiUser _user = HobiUser.withDefault();
  UserStateInSplashScreen _userState = UserStateInSplashScreen.SplashSession;
  final AuthServices _authServices = AuthServices();

  //MARK: INIT
  SplashViewModel() {
    checkUser();
  }

  //MARK: GETTERS
  HobiUser get user => _user;
  UserStateInSplashScreen get userState => _userState;

  //MARK: SETTERS
  void setUser(HobiUser user) {
    _user = user;
    notifyListeners();
  }

  void setUserState(UserStateInSplashScreen userState) {
    _userState = userState;
    notifyListeners();
  }

  void addHobby(String hobby) {
    _user.hobbies.add(hobby);
    notifyListeners();
  }

  //MARK: CHECK USER
  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    await getUser();
  }

  //MARK: GET USER
  Future<void> getUser() async {
    final response = await _authServices.currentUser();
    if (response.success) {
      setUser(response.hobiUser!);
      setUserState(UserStateInSplashScreen.UserWithActiveSession);
    } else {
      setUserState(UserStateInSplashScreen.UserWithoutActiveSession);
    }
  }
}

enum UserStateInSplashScreen {
  UserWithActiveSession,
  UserWithoutActiveSession,
  SplashSession,
}
