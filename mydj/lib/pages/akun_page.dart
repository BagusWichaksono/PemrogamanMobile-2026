import 'package:flutter/material.dart';
import 'package:mydj/components/password_field.dart';
import 'package:mydj/data/login_info.dart';
import 'package:mydj/pages/login_page.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key, this.title = 'Akun'});
  final String title;

  @override
  State<AkunPage> createState() {
    return _AkunPageState();
  }
}

class _AkunPageState extends State<AkunPage> {
  void _openLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await LoginInfo.deleteFromSharedPreferences();
    if (context.mounted) {
      _openLoginPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ganti Sandi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              const Text('Sandi Saat Ini'),
              const SizedBox(height: 10),
              const PasswordField(),
              const SizedBox(height: 10),
              const Text('Sandi Baru'),
              const SizedBox(height: 10),
              const PasswordField(),
              const SizedBox(height: 10),
              const Text('Konfirmasi Sandi Baru'),
              const SizedBox(height: 10),
              const PasswordField(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Simpan'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Keluar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  child: const Text('Keluar dari Aplikasi'),
                  onPressed: () {
                    _logout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
