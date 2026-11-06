import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const FormBiodata(title: 'Form Biodata'),
    );
  }
}

//Halaman 1 Form Biodata
class FormBiodata extends StatefulWidget {
  const FormBiodata({super.key, required this.title});
  final String title;

  @override
  State<FormBiodata> createState() => _FormBiodataState();
}

class _FormBiodataState extends State<FormBiodata> {
  // Variabel
  String _nama = '';
  String _nim = '';
  String _email = '';
  String? _jeniskelamin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Nama
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Lengkap',
                ),
                onChanged: (value) {
                  setState(() {
                    _nama = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // NIM
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NIM',
                ),
                onChanged: (value) {
                  setState(() {
                    _nim = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Email
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Dropdown Jenis kelamin
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Jenis kelamin',
                ),
                items: const [
                  DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                ],
                onChanged: (value) {
                  setState(() {
                    _jeniskelamin = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Button Lanjut
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Pindah ke Halaman 2 dan membawa data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HalamanKonfirmasi(
                          nama: _nama,
                          nim: _nim,
                          email: _email,
                          jeniskelamin: _jeniskelamin ?? '',
                        ),
                      ),
                    );
                  },
                  child: const Text('Lanjut'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman 2 Konfirmasi
class HalamanKonfirmasi extends StatelessWidget {
  final String nama;
  final String nim;
  final String email;
  final String jeniskelamin;

  const HalamanKonfirmasi({
    super.key,
    required this.nama,
    required this.nim,
    required this.email,
    required this.jeniskelamin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Konfirmasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan semua data yang diisi
            Text('Nama: $nama'),
            const SizedBox(height: 10),
            Text('NIM: $nim'),
            const SizedBox(height: 10),
            Text('Email: $email'),
            const SizedBox(height: 10),
            Text('Jenis Kelamin: $jeniskelamin'),
            const SizedBox(height: 30),

            // Tombol Konfirmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Menampilkan SnackBar saat tombol diklik
                  SnackBar snackBar = const SnackBar(
                    content: Text('Data berhasil dikirim'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text('Konfirmasi data saya dan kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}