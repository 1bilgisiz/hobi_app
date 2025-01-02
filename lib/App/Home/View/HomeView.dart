import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hobiapp/App/Components/MainFormTextField.dart';
import 'package:hobiapp/App/Home/View%20Model/HomeViewModel.dart';
import 'package:hobiapp/App/Home/View/DrawerMenu.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:hobiapp/Utils/Default.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<FormState> _homeFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final splashVM = Provider.of<SplashViewModel>(context);
    final homeVM = Provider.of<HomeViewModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Hobiler"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final response = await homeVM.logout(splashVM);
              if (response) {
                // ignore: use_build_context_synchronously
                context.go("/loginView");
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Default.globalHPaddingValue, vertical: 20),
        child: Column(
          children: [
            // Hobbi Ekleme Alanı
            Form(
              key: _homeFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: MainFormTextField(
                      hintText: "Hobbi Ekle",
                      prefixIcon: const Icon(Icons.sports_esports),
                      validator: (hobby) => homeVM.validateHobby(hobby),
                      onChanged: (hobby) => homeVM.setHobby(hobby), initialValue: null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_homeFormKey.currentState!.validate()) {
                        homeVM.addHobby(splashVM);
                        _homeFormKey.currentState!.reset();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade300,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            // Hobiler Listesi
            Expanded(
              child: splashVM.user.hobbies.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: splashVM.user.hobbies.length,
                      itemBuilder: (context, index) {
                        final hobby = splashVM.user.hobbies[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.pink.shade100,
                          child: Center(
                            child: Text(
                              hobby,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "Henüz bir hobiniz yok.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
