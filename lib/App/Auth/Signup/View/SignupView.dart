import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hobiapp/App/Auth/Signup/View%20Model/SignupViewModel.dart';
import 'package:hobiapp/App/Components/MainDateAndTimePicker.dart';
import 'package:hobiapp/App/Components/MainFormTextField.dart';
import 'package:hobiapp/App/Components/ShowMessageAlertWidget.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Routes/AppRouter.dart';
import 'package:hobiapp/Utils/Default.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _signupFormkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final signupVM = Provider.of<SignupViewModel>(context);
    final splashVM = Provider.of<SplashViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Üye ol"),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Default.globalHPaddingValue),
        child: Form(
          key: _signupFormkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MainFormTextField(
                        hintText: "Ad",
                        prefixIcon: const Icon(Icons.person),
                        validator: (name) => signupVM.validateName(name),
                        onChanged: (name) => signupVM.setName(name),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MainFormTextField(
                        hintText: "Soyad",
                        prefixIcon: const Icon(Icons.person),
                        validator: (surname) =>
                            signupVM.validateSurname(surname),
                        onChanged: (surname) => signupVM.setSurname(surname),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MainFormTextField(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  validator: (email) => signupVM.validateEmail(email),
                  onChanged: (email) => signupVM.setEmail(email),
                ),
                const SizedBox(height: 10),
                MainFormTextField(
                  maxLines: 3,
                  hintText: "Biyografi",
                  prefixIcon: null,
                  validator: (biography) =>
                      signupVM.validateBiography(biography),
                  onChanged: (biography) => signupVM.setBiograpy(biography),
                ),
                const SizedBox(height: 10),
                MainDateAndTimePicker(
                  validateWidget: signupVM.birthOfDate == null
                      ? const Text(
                          "Lütfen doğum tarihinizi seçiniz",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        )
                      : const SizedBox.shrink(),
                  text: "Doğum Tarihi",
                  setFunction: (DateTime birthOfDate) =>
                      signupVM.setBirthOfDate(birthOfDate),
                  selectTime: signupVM.birthOfDate,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MainFormTextField(
                        obscureText: signupVM.obscurePasswordText,
                        hintText: "Şifre",
                        prefixIcon: const Icon(Icons.lock),
                        validator: (password) =>
                            signupVM.validatePassword(password),
                        onChanged: (password) => signupVM.setPassword(password),
                        suffixIcon: IconButton(
                          onPressed: () => signupVM.setPasswordObsureText(
                              !signupVM.obscurePasswordText),
                          icon: Icon(
                            signupVM.obscurePasswordText
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MainFormTextField(
                        obscureText: signupVM.obscureConfirmPasswordText,
                        hintText: "Şifre tekrar",
                        prefixIcon: const Icon(Icons.lock),
                        validator: (password) =>
                            signupVM.validateConfirmPassword(password),
                        onChanged: (password) =>
                            signupVM.setConfirmPassword(password),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              signupVM.setConfirmPasswordObsureText(
                                  !signupVM.obscureConfirmPasswordText),
                          icon: Icon(
                            signupVM.obscureConfirmPasswordText
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_signupFormkey.currentState!.validate()) {
                        signup(signupVM, splashVM);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Hesap oluştur",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Zaten bir hesabınız var mı?  "),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RoutesNames.loginView);
                      },
                      child: Text(
                        "Giriş Yap",
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

  Future<void> signup(
      SignupViewModel signupVM, SplashViewModel splashVM) async {
    final response = await signupVM.createAccount(splashVM);
    if (response == null) {
      _signupFormkey.currentState!.reset();
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
