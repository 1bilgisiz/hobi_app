import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hobiapp/App/Components/MainFormTextField.dart';
import 'package:hobiapp/App/Home/View%20Model/HomeViewModel.dart';
import 'package:hobiapp/App/Home/View/Components/InfromationWidget.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Utils/Default.dart';
import 'package:hobiapp/Utils/Palette.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<FormState> _homeFormkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final splashVM = Provider.of<SplashViewModel>(context);
    final homeVM = Provider.of<HomeViewModel>(context);
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Anasayfa"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                final response = await homeVM.logout(splashVM);
                if (response) {
                  context.go("/loginView");
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Default.globalHPaddingValue),
          child: SizedBox(
            width: width,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        spreadRadius: 1,
                        blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InformationWidget(
                              information: splashVM.user.name),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InformationWidget(
                              information: splashVM.user.surname),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Palette.lightGrey2.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              splashVM.user.email,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Palette.lightGrey2.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Doğum Tarihi: ${DateFormat("dd/MM/yyyy").format(splashVM.user.birthOfDate)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Palette.lightGrey2.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              splashVM.user.biography,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 1),
                    const SizedBox(height: 10),
                    const Text(
                      "Hobbies",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _homeFormkey,
                      child: MainFormTextField(
                        hintText: "Hobbi Ekle",
                        prefixIcon: null,
                        validator: (hobby) => homeVM.validateHobby(hobby),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (_homeFormkey.currentState!.validate()) {
                              homeVM.addHobby(splashVM);
                              _homeFormkey.currentState!.reset();
                            }
                          },
                          icon: const Icon(Icons.add),
                        ),
                        onChanged: (hobby) => homeVM.setHobby(hobby),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: splashVM.user.hobbies
                            .map((e) => InformationWidget(information: e))
                            .toList(),
                      ),
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
}
