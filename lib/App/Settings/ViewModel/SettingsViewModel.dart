import 'package:flutter/material.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Data/Settings/Request/UserUpdateRequest.dart';
import 'package:hobiapp/Data/Settings/SettingsServices.dart';
import 'package:hobiapp/Model/HobiUser.dart';

class SettingsViewModel with ChangeNotifier {
  String _name = '';
  String _surname = '';
  String _biography = '';
  DateTime? _birthDate;

  //MARK: GETTERS
  DateTime? get birthDate => _birthDate;

  //MARK: SETTERS
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set surname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  set birthDate(DateTime? birthDate) {
    _birthDate = birthDate;
    notifyListeners();
  }

  set biography(String biography) {
    _biography = biography;
    notifyListeners();
  }

  //MARK: RESET VALUES
  void resetValues() {
    _name = '';
    _surname = '';
    _biography = '';
    _birthDate = null;
    notifyListeners();
  }

  //MARK: GET USER UPDATE SETTINGS
  UserUpdateRequest get userUpdateRequest => UserUpdateRequest(
        name: _name,
        surname: _surname,
        birthOfDate: _birthDate ?? DateTime(0),
        biography: _biography,
      );

  //MARK: UPDATE SETTINGS
  Future<bool> updateSettings({
    required String id,
    required SplashViewModel splashVM,
  }) async {
    final response = await SettingsServices().updateSettings(
      id: id,
      userSettigs: userUpdateRequest,
    );
    if (response) {
      HobiUser user = splashVM.user;
      user.name = _name;
      user.surname = _surname;
      user.birthOfDate = _birthDate ?? user.birthOfDate;
      user.biography = _biography;
      splashVM.setUser(user);
      resetValues();
      return true;
    }
    {
      return false;
    }
  }
}
