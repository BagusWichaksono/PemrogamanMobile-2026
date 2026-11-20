import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TentangAplikasiPage extends StatefulWidget {
  const TentangAplikasiPage({super.key, this.title = 'Tentang Aplikasi'});
  final String title;

  @override
  State<TentangAplikasiPage> createState() {
    return _TentangAplikasiPageState();
  }
}

class _TentangAplikasiPageState extends State<TentangAplikasiPage> {
  final String _url = 'https://polinema.ac.id';

  Future<void> _bukaUrl() async {
    final Uri uri = Uri.parse(_url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_kemdikbud.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                'MyDJ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Aplikasi Jurnal Harian Guru',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                'Version: 1.0.0',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Dibuat oleh: Bagus Wichaksono',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: _bukaUrl,
                child: Text(
                  _url,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
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
