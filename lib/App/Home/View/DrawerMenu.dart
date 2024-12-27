import 'package:flutter/material.dart';
import 'package:hobiapp/App/Auth/Login/View/LoginView.dart';
import 'package:hobiapp/App/Home/View/HomeView.dart';
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
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.pink.shade100,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 60, color: Colors.black), // Boyut büyütüldü
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${splashVM.user.name} ${splashVM.user.surname}', // İsim ve soyisim birleştirildi
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  splashVM.user.email,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Text(
                  "Doğum Tarihi: ${DateFormat("dd/MM/yyyy").format(splashVM.user.birthOfDate)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Text(
                  splashVM.user.biography,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white70),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: Column(
              children: [
                // Home Menu Item
                ListTile(
                  leading: Icon(Icons.home, color: Colors.pink.shade100),
                  title: const Center(
                    child: Text('Ana Sayfa'),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()));
                  },
                ),

                // Settings Menu Item
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.pink),
                  title: const Center(
                    child: Text('Ayarlar'),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                ),

                // Logout Menu Item
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Center(
                    child: Text('Çıkış Yap'),
                  ),
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

  // Logout Confirmation Dialog
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );
  }
}
