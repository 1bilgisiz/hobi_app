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
  final GlobalKey<FormState> _resetFormkey = GlobalKey<FormState>();

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
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                          ),
                          context: context,
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.white,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setValue) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  width: width,
                                  child: SizedBox(
                                    height: 165,
                                    width: width,
                                    child: Form(
                                      key: _resetFormkey,
                                      child: Column(
                                        children: [
                                          MainFormTextField(
                                            hintText: "Email",
                                            prefixIcon: const Icon(Icons.email),
                                            validator: (email) =>
                                                loginVM.validateEmail(email),
                                            onChanged: (email) => setValue(
                                              () =>
                                                  loginVM.setResetEmail(email),
                                            ),
                                            initialValue: null,
                                          ),
                                          const SizedBox(height: 10),
                                          InkWell(
                                            onTap: () async {
                                              if (_resetFormkey.currentState!
                                                  .validate()) {
                                                final response = await loginVM
                                                    .resetPassword();
                                                if (response != null) {
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
                                                } else {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    // ignore: use_build_context_synchronously
                                                    context: context,
                                                    builder: (_) {
                                                      return const ShowMessageAlertWidget(
                                                        title: "Başarılı",
                                                        description:
                                                            'Şifre değiştirme bağlantısı mail adreinize göndeirlmiştir.',
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: width,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              child: const Text(
                                                "Şifreyi sıfırla",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Şifremi unuttum",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
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
