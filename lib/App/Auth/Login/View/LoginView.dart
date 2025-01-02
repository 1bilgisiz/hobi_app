import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hobiapp/App/Auth/Login/View%20Model/LoginViewModel.dart';
import 'package:hobiapp/App/Components/MainFormTextField.dart';
import 'package:hobiapp/App/Components/ShowMessageAlertWidget.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Routes/AppRouter.dart';

import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final loginVM = Provider.of<LoginViewModel>(context);
    final splashVM = Provider.of<SplashViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _loginFormkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.lock_outline,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Hoşgeldiniz!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Lütfen giriş yapın",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    MainFormTextField(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      validator: (email) => loginVM.validateEmail(email),
                      onChanged: (email) => loginVM.setEmail(email),
                      initialValue: null,
                    ),
                    const SizedBox(height: 20),
                    MainFormTextField(
                      obscureText: loginVM.obscurePasswordText,
                      hintText: "Şifre",
                      prefixIcon: const Icon(Icons.lock),
                      validator: (password) =>
                          loginVM.validatePassword(password),
                      onChanged: (password) => loginVM.setPassword(password),
                      suffixIcon: IconButton(
                        onPressed: () => loginVM.setPasswordObsureText(
                            !loginVM.obscurePasswordText),
                        icon: Icon(
                          loginVM.obscurePasswordText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                      ),
                      initialValue: null,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_loginFormkey.currentState!.validate()) {
                            login(loginVM, splashVM);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          "Giriş Yap",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Hesabınız yok mu?",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(RoutesNames.signupView);
                          },
                          child: const Text(
                            " Kayıt Ol",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(LoginViewModel loginVM, SplashViewModel splashVM) async {
    final response = await loginVM.login(splashVM);
    if (response == null) {
      _loginFormkey.currentState!.reset();
      context.pushNamed(RoutesNames.homeView);
    } else {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (_) {
          return ShowMessageAlertWidget(
            title: "Başarısız",
            description: response,
          );
        },
      );
    }
  }
}
