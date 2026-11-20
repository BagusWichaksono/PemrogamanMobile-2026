import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mydj/components/password_field.dart';
import 'package:mydj/data/data_provider.dart';
import 'package:mydj/pages/simple_home_page.dart';

class LoginPage extends StatefulWidget {
  final String title = 'MyDJ - Welcome';

  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String namaPengguna = ''; // <-- Nantinya digunakan untuk menyimpan username
  String sandi = ''; // <-- Yang ini digunakan untuk menyimpan password

  Future<void> _login(BuildContext context) async {
    // Ambil instance Provider (state management) kita dari BuildContext
    DataProvider provider = context.read<DataProvider>();
    // Jika username dan password benar..
    if (namaPengguna == 'guru' && sandi == 'guru') {
      // Simpan info login lewat Provider (State Management)
      await provider.saveLoginInfo(namaPengguna, sandi);
      // Jika ingin menggunakan BuildContext dalam operasi async, harus dicek dulu
      if (context.mounted) {
        // Buka halaman home
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SimpleHomePage(title: 'Jurnal Harian Guru'),
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nama pengguna atau sandi salah! Gunakan guru / guru'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/login_icon.png', width: 220), // <-- Menampilkan gambar login
                const SizedBox(height: 10),
                const Text(
                  'Log-In',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Nama Pengguna:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      namaPengguna = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sandi:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                PasswordField(
                  onChanged: (value) {
                    setState(() {
                      sandi = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _login(context),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
