import 'package:flutter/material.dart';
import 'package:hobiapp/App/Auth/Login/View/LoginView.dart';
import 'package:hobiapp/App/Home/View/HomeView.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final splashVM = Provider.of<SplashViewModel>(context);
    if (splashVM.userState == UserStateInSplashScreen.SplashSession) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      if (splashVM.userState == UserStateInSplashScreen.UserWithActiveSession) {
        return const HomeView();
      } else {
        return const LoginView();
      }
    }
  }
}
