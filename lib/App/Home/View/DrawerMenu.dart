import 'package:flutter/material.dart';
import 'package:hobiapp/App/Auth/Login/View/LoginView.dart';
import 'package:hobiapp/App/Home/View/HomeView.dart';
import 'package:hobiapp/App/Settings/View/SettingView.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final splashVM = Provider.of<SplashViewModel>(context);

    return Drawer(
      child: Column(
        children: [
          // Kullanıcı Bilgileri
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade100, Colors.pink.shade300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: Colors.black),
                ),
                const SizedBox(height: 16),
                Text(
                  '${splashVM.user.name} ${splashVM.user.surname}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.white70),
                    const SizedBox(width: 8),
                    Text(
                      splashVM.user.email,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.cake, color: Colors.white70),
                    const SizedBox(width: 8),
                    Text(
                      "Doğum Tarihi: ${DateFormat("dd/MM/yyyy").format(splashVM.user.birthOfDate)}",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.computer, color: Colors.white70),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: Text(
                          "Biyografi : ${splashVM.user.biography}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Menü Öğeleri
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: Colors.pink.shade300),
                  title: const Text('Ana Sayfa'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.pink),
                  title: const Text('Ayarlar'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingView()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Çıkış Yap'),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Çıkış Diyaloğu
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text('Çıkış yapmak istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );
  }
}
