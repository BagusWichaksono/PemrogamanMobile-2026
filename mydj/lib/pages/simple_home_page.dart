import 'package:flutter/material.dart';
import 'package:mydj/pages/liat_jurnal_page.dart';
import 'package:mydj/pages/buat_jurnal_page.dart';
import 'package:mydj/pages/akun_page.dart';
import 'package:mydj/pages/tentang_aplikasi_page.dart';

class SimpleHomePage extends StatefulWidget {
  const SimpleHomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SimpleHomePageState(); // Tidak masalah bila saat ini error karena memang class _SimpleHomePageState belum kita buat.
  }
}

class _SimpleHomePageState extends State<SimpleHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/images/logo_kemdikbud.png',
                width: 150,
                height: 150
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => {_openLihatJurnalPage(context)}, child: Text('Lihat Jurnal')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: ( ) => {_openBuatJurnalPage(context)}, child: Text('Buat Jurnal')),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: ( ) => {_openAkunPage(context)}, child: Text('Akun')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: ( ) => {_openTentangAplikasiPage(context)}, child: Text('Tentang Aplikasi')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _openLihatJurnalPage(BuildContext context)
{
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LihatJurnalPage(title: 'Lihat Jurnal')
          // Halaman kedua (Widget)
    ),
  );
}

void _openBuatJurnalPage(BuildContext context)
{
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BuatJurnalPage(title: 'Buat Jurnal')
          // Halaman kedua (Widget)
    ),
  );
}

void _openAkunPage(BuildContext context)
{
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AkunPage(title: 'Akun')
          // Halaman kedua (Widget)
    ),
  );
}

void _openTentangAplikasiPage(BuildContext context)
{
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => TentangAplikasiPage(title: 'Tentang Aplikasi')
      // Halaman kedua (Widget)
    ),
  );
}