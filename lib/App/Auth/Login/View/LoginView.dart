import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hobiapp/App/Auth/Login/View%20Model/LoginViewModel.dart';
import 'package:hobiapp/App/Components/MainFormTextField.dart';
import 'package:hobiapp/App/Components/ShowMessageAlertWidget.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Routes/AppRouter.dart';
import 'package:hobiapp/Utils/Default.dart';
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
      appBar: AppBar(
        title: const Text("Giriş Yap"),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Default.globalHPaddingValue),
        child: Form(
          key: _loginFormkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                MainFormTextField(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  validator: (email) => loginVM.validateEmail(email),
                  onChanged: (email) => loginVM.setEmail(email),
                ),
                const SizedBox(height: 10),
                MainFormTextField(
                  obscureText: loginVM.obscurePasswordText,
                  hintText: "Şifre",
                  prefixIcon: const Icon(Icons.lock),
                  validator: (password) => loginVM.validatePassword(password),
                  onChanged: (password) => loginVM.setPassword(password),
                  suffixIcon: IconButton(
                    onPressed: () => loginVM
                        .setPasswordObsureText(!loginVM.obscurePasswordText),
                    icon: Icon(
                      loginVM.obscurePasswordText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_loginFormkey.currentState!.validate()) {
                        login(loginVM, splashVM);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Hesabınız yok mu?  "),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RoutesNames.signupView);
                      },
                      child: Text(
                        "Kayıt ol",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
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
