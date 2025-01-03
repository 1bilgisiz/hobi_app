import 'package:flutter/material.dart';
import 'package:hobiapp/App/Home/View/DrawerMenu.dart';
import 'package:hobiapp/App/Settings/ViewModel/SettingsViewModel.dart';
import 'package:hobiapp/App/Splash/View%20Model/SplashViewModel.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final splashVM = Provider.of<SplashViewModel>(context);
    final settingsVM = Provider.of<SettingsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: Colors.pink.shade300,
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Ad Soyad Alanı
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Ad',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ad giriniz';
                        }
                        return null;
                      },
                      onChanged: (value) => settingsVM.name = value,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Soyad',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Soyad giriniz';
                        }
                        return null;
                      },
                      onChanged: (value) => settingsVM.surname = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Biyografi',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Biyografinizi giriniz';
                  }
                  return null;
                },
                onChanged: (value) => settingsVM.biography = value,
              ),

              const SizedBox(height: 10),

              // Doğum Tarihi Alanı
              GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: settingsVM.birthDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    settingsVM.birthDate = selectedDate;
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Doğum Tarihi',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    settingsVM.birthDate == null
                        ? 'Tarih seçiniz'
                        : '${settingsVM.birthDate!.day}/${settingsVM.birthDate!.month}/${settingsVM.birthDate!.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Kaydet Butonu
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await settingsVM.updateSettings(
                          id: splashVM.user.id, splashVM: splashVM);
                      if (response) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ayarlar güncellendi')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Ayarlar güncellenmedi')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Ayarları Kaydet',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
