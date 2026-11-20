import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mydj/components/media_selector.dart';
import 'package:mydj/data/data_provider.dart';
import 'package:mydj/data/jurnal.dart';

class BuatJurnalPage extends StatefulWidget {
  final String title;
  final Jurnal? jurnal;

  const BuatJurnalPage({
    super.key,
    this.title = 'Buat Jurnal',
    this.jurnal,
  });

  @override
  State<BuatJurnalPage> createState() {
    return _BuatJurnalPageState();
  }
}

class _BuatJurnalPageState extends State<BuatJurnalPage> {
  String kelas = '';
  String mapel = '';
  int jamKe = 0;
  String tujuanPembelajaran = '';
  String materiTopikPembelajaran = '';
  String kegiatanPembelajaran = '';
  String dimensiProfilPelajarPancasila = '';

  late TextEditingController _kelasController;
  late TextEditingController _mapelController;
  late TextEditingController _tujuanController;
  late TextEditingController _materiController;
  late TextEditingController _kegiatanController;
  late TextEditingController _dimensiController;

  @override
  void initState() {
    super.initState();
    if (widget.jurnal != null) {
      kelas = widget.jurnal!.kelas;
      mapel = widget.jurnal!.mapel;
      jamKe = widget.jurnal!.jam;
      tujuanPembelajaran = widget.jurnal!.tujuanPembelajaran;
      materiTopikPembelajaran = widget.jurnal!.materiTopikPembelajaran;
      kegiatanPembelajaran = widget.jurnal!.kegiatanPembelajaran;
      dimensiProfilPelajarPancasila =
          widget.jurnal!.dimensiProfilPelajarPancasila;
    }

    _kelasController = TextEditingController(text: kelas);
    _mapelController = TextEditingController(text: mapel);
    _tujuanController = TextEditingController(text: tujuanPembelajaran);
    _materiController = TextEditingController(text: materiTopikPembelajaran);
    _kegiatanController = TextEditingController(text: kegiatanPembelajaran);
    _dimensiController =
        TextEditingController(text: dimensiProfilPelajarPancasila);
  }

  @override
  void dispose() {
    _kelasController.dispose();
    _mapelController.dispose();
    _tujuanController.dispose();
    _materiController.dispose();
    _kegiatanController.dispose();
    _dimensiController.dispose();
    super.dispose();
  }

  Future<void> _saveJurnal(BuildContext context) async {
    DataProvider provider = context.read<DataProvider>();

    if (widget.jurnal != null) {
      // Mode Edit: update baris yang ada
      Jurnal updatedJurnal = Jurnal(
        id: widget.jurnal!.id,
        kelas: kelas,
        mapel: mapel,
        jam: jamKe,
        tujuanPembelajaran: tujuanPembelajaran,
        materiTopikPembelajaran: materiTopikPembelajaran,
        kegiatanPembelajaran: kegiatanPembelajaran,
        dimensiProfilPelajarPancasila: dimensiProfilPelajarPancasila,
        createdAt: widget.jurnal!.createdAt,
      );
      await provider.ubahJurnal(updatedJurnal);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jurnal berhasil diperbarui')),
        );
        Navigator.pop(context);
      }
    } else {
      // Mode Tambah Jurnal Baru
      Jurnal jurnal = Jurnal(
        kelas: kelas,
        mapel: mapel,
        jam: jamKe,
        tujuanPembelajaran: tujuanPembelajaran,
        materiTopikPembelajaran: materiTopikPembelajaran,
        kegiatanPembelajaran: kegiatanPembelajaran,
        dimensiProfilPelajarPancasila: dimensiProfilPelajarPancasila,
      );
      await provider.tambahJurnal(jurnal);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jurnal berhasil disimpan')),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Kelas:'),
              const SizedBox(height: 10),
              TextField(
                controller: _kelasController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Kelas',
                ),
                onChanged: (value) => {
                  setState(() {
                    kelas = value;
                  })
                },
              ),
              const SizedBox(height: 10),
              const Text('Nama Mapel'),
              const SizedBox(height: 10),
              TextField(
                controller: _mapelController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Nama Mapel',
                ),
                onChanged: (value) => {
                  setState(() {
                    mapel = value;
                  })
                },
              ),
              const SizedBox(height: 10),
              const Text('Jam Ke-'),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue:
                    (jamKe >= 1 && jamKe <= 8) ? jamKe.toString() : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pilih Jam',
                ),
                items: const [
                  DropdownMenuItem(value: '1', child: Text('1')),
                  DropdownMenuItem(value: '2', child: Text('2')),
                  DropdownMenuItem(value: '3', child: Text('3')),
                  DropdownMenuItem(value: '4', child: Text('4')),
                  DropdownMenuItem(value: '5', child: Text('5')),
                  DropdownMenuItem(value: '6', child: Text('6')),
                  DropdownMenuItem(value: '7', child: Text('7')),
                  DropdownMenuItem(value: '8', child: Text('8')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      jamKe = int.tryParse(value) ?? 0;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              _textArea(
                'Tujuan Pembelajaran',
                'Masukkan Tujuan Pembelajaran',
                _tujuanController,
                (text) {
                  tujuanPembelajaran = text;
                },
              ),
              const SizedBox(height: 10),
              _textArea(
                'Materi/Topik Pembelajaran',
                'Masukkan Materi/Topik Pembelajaran',
                _materiController,
                (text) {
                  materiTopikPembelajaran = text;
                },
              ),
              const SizedBox(height: 10),
              _textArea(
                'Kegiatan Pembelajaran',
                'Masukkan Kegiatan Pembelajaran',
                _kegiatanController,
                (text) {
                  kegiatanPembelajaran = text;
                },
              ),
              const SizedBox(height: 10),
              _textArea(
                'Dimensi Profil Pelajar Pancasila',
                'Tuliskan Dimensi Profil Pelajar Pancasila',
                _dimensiController,
                (text) {
                  dimensiProfilPelajarPancasila = text;
                },
              ),
              /* Tambahkan di sini */
              const SizedBox(height: 10),
              const Text('Foto Kegiatan'),
              const SizedBox(height: 10),
              const MediaSelector(), // <-- MediaSelector untuk foto.
              const SizedBox(height: 10),
              const Text('Video Kegiatan'),
              const SizedBox(height: 10),
              const MediaSelector(
                  mediaType: MediaType.video), // <-- MediaSelector untuk video.
              /* Sebelum button Simpan ini */
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _saveJurnal(context),
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textArea(String label, String hint, TextEditingController controller,
      void Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: hint,
          ),
          maxLines: 4,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
