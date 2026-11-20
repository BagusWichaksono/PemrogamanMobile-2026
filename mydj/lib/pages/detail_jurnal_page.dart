import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mydj/data/data_provider.dart';
import 'package:mydj/data/jurnal.dart';
import 'package:mydj/pages/buat_jurnal_page.dart';

class DetailJurnalPage extends StatefulWidget {
  final Jurnal jurnal;

  const DetailJurnalPage({super.key, required this.jurnal});

  @override
  State<DetailJurnalPage> createState() => _DetailJurnalPageState();
}

class _DetailJurnalPageState extends State<DetailJurnalPage> {
  @override
  Widget build(BuildContext context) {
    // Ambil data terbaru dari DataProvider jika ada pembaruan
    final currentJurnal = context.watch<DataProvider>().jurnalTersimpan.firstWhere(
          (j) => j.id == widget.jurnal.id,
          orElse: () => widget.jurnal,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Jurnal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemDetail('Kelas', currentJurnal.kelas),
            const Divider(),
            _itemDetail('Mata Pelajaran', currentJurnal.mapel),
            const Divider(),
            _itemDetail('Jam Ke-', currentJurnal.jam.toString()),
            const Divider(),
            _itemDetail('Tujuan Pembelajaran', currentJurnal.tujuanPembelajaran),
            const Divider(),
            _itemDetail('Materi / Topik Pembelajaran',
                currentJurnal.materiTopikPembelajaran),
            const Divider(),
            _itemDetail(
                'Kegiatan Pembelajaran', currentJurnal.kegiatanPembelajaran),
            const Divider(),
            _itemDetail('Dimensi Profil Pelajar Pancasila',
                currentJurnal.dimensiProfilPelajarPancasila),
            const Divider(),
            _itemDetail('Waktu Dibuat', currentJurnal.createdAt.toString()),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuatJurnalPage(
                        title: 'Edit Jurnal',
                        jurnal: currentJurnal,
                      ),
                    ),
                  );
                },
                child: const Text('Edit Jurnal Ini'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF0D253F), // Biru tua
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : '-',
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
