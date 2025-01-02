import 'package:flutter/material.dart';
import 'package:hobiapp/App/Home/View/DrawerMenu.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _surname = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  DateTime? _birthDate;
  bool _obscurePasswordText = true;
  bool _obscureConfirmPasswordText = true;

  @override
  Widget build(BuildContext context) {
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
                      initialValue: _name,
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
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: _surname,
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
                      onChanged: (value) {
                        setState(() {
                          _surname = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Email Alanı
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Geçerli bir email giriniz';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              // Şifre Alanı
              TextFormField(
                obscureText: _obscurePasswordText,
                initialValue: _password,
                decoration: InputDecoration(
                  labelText: 'Yeni Şifre',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePasswordText = !_obscurePasswordText;
                      });
                    },
                    icon: Icon(
                      _obscurePasswordText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre giriniz';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              // Şifre Tekrar Alanı
              TextFormField(
                obscureText: _obscureConfirmPasswordText,
                initialValue: _confirmPassword,
                decoration: InputDecoration(
                  labelText: 'Yeni Şifre Tekrarı',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPasswordText =
                            !_obscureConfirmPasswordText;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPasswordText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre tekrarını giriniz';
                  }
                  if (value != _password) {
                    return 'Şifreler uyuşmuyor';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              // Doğum Tarihi Alanı
              GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _birthDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _birthDate = selectedDate;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Doğum Tarihi',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _birthDate == null
                        ? 'Tarih seçiniz'
                        : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form geçerli ise işlemi gerçekleştir
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ayarlar güncellendi')),
                      );
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
