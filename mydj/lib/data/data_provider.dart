import 'package:flutter/material.dart';
import 'package:mydj/data/database_helper.dart';
import 'package:mydj/data/jurnal.dart';
import 'package:mydj/data/login_info.dart';

class DataProvider extends ChangeNotifier {
  // Inisialisasi awal dengan data contoh sesuai screenshot Jobsheet 12 halaman 8
  List<Jurnal> _jurnalTersimpan = [
    Jurnal(
      id: 2,
      kelas: 'TI-3B',
      mapel: 'Pemrograman Mobile',
      jam: 2,
      tujuanPembelajaran: 'Persistensi data lokal dengan SQLite',
      materiTopikPembelajaran: 'Persistensi SQLite',
      kegiatanPembelajaran: 'Praktik CRUD data jurnal',
      dimensiProfilPelajarPancasila: 'Mandiri, Bernalar Kritis',
      createdAt: DateTime.parse('2026-11-12 07:40:17.358077'),
    ),
    Jurnal(
      id: 1,
      kelas: 'TI-3A',
      mapel: 'Pemrograman Mobile',
      jam: 1,
      tujuanPembelajaran: 'Mempelajari dasar widget formulir',
      materiTopikPembelajaran: 'Dasar Widget',
      kegiatanPembelajaran: 'Praktik membuat input dan validasi',
      dimensiProfilPelajarPancasila: 'Mandiri, Bernalar Kritis',
      createdAt: DateTime.parse('2026-11-12 07:39:58.509987'),
    ),
  ];

  List<Jurnal> get jurnalTersimpan => _jurnalTersimpan;
  List<Jurnal> get daftarJurnal => _jurnalTersimpan;

  // Pertemuan 8: addNew
  void addNew(Jurnal jurnal) {
    tambahJurnal(jurnal);
  }

  // READ: ambil semua jurnal dari database
  Future<void> muatJurnal() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final rows = await db.query('jurnal', orderBy: 'id DESC');

      if (rows.isEmpty) {
        // Jika tabel SQLite masih baru dibuat / kosong, sinkronkan data awal ke SQLite
        for (final item in _jurnalTersimpan) {
          await db.insert('jurnal', item.toMap());
        }
        final updatedRows = await db.query('jurnal', orderBy: 'id DESC');
        if (updatedRows.isNotEmpty) {
          _jurnalTersimpan =
              updatedRows.map((row) => Jurnal.fromMap(row)).toList();
        }
      } else {
        _jurnalTersimpan = rows.map((row) => Jurnal.fromMap(row)).toList();
      }
    } catch (e) {
      debugPrint('Info: SQLite database fallback ke memori: $e');
    }
    notifyListeners();
  }

  // CREATE: simpan jurnal baru, lalu muat ulang daftarnya
  Future<void> tambahJurnal(Jurnal jurnal) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final id = await db.insert('jurnal', jurnal.toMap());
      jurnal.id = id;
    } catch (e) {
      debugPrint('Info: Simpan jurnal ke database fallback: $e');
      final currentMaxId = _jurnalTersimpan.isEmpty
          ? 0
          : (_jurnalTersimpan.map((j) => j.id ?? 0).reduce((a, b) => a > b ? a : b));
      jurnal.id = currentMaxId + 1;
    }

    if (!_jurnalTersimpan.any((j) => j.id == jurnal.id && j.id != null)) {
      _jurnalTersimpan.insert(0, jurnal);
    }
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;
      final rows = await db.query('jurnal', orderBy: 'id DESC');
      if (rows.isNotEmpty) {
        _jurnalTersimpan = rows.map((row) => Jurnal.fromMap(row)).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  // UPDATE: perbarui data jurnal di SQLite dan state lokal
  Future<void> ubahJurnal(Jurnal jurnal) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'jurnal',
        jurnal.toMap(),
        where: 'id = ?',
        whereArgs: [jurnal.id],
      );
    } catch (e) {
      debugPrint('Info: Ubah jurnal SQLite fallback: $e');
    }

    final index = _jurnalTersimpan.indexWhere((j) => j.id == jurnal.id);
    if (index != -1) {
      _jurnalTersimpan[index] = jurnal;
    }
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;
      final rows = await db.query('jurnal', orderBy: 'id DESC');
      if (rows.isNotEmpty) {
        _jurnalTersimpan = rows.map((row) => Jurnal.fromMap(row)).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  // DELETE: hapus jurnal berdasarkan id, lalu muat ulang daftarnya
  Future<void> hapusJurnal(int id) async {
    _jurnalTersimpan.removeWhere((j) => j.id == id);
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('jurnal', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint('Info: Hapus jurnal dari SQLite: $e');
    }
  }

  // Cek sudah login atau belum
  Future<bool> isLoggedIn() async {
    LoginInfo loginInfo = await LoginInfo.fromSharedPreferences();
    return loginInfo.isLoggedIn;
  }

  // Simpan informasi sesi ketika login
  Future<void> saveLoginInfo(String username, String password) async {
    LoginInfo loginInfo = await LoginInfo.fromSharedPreferences();
    // Isi
    loginInfo.username = username;
    loginInfo.password = password;
    loginInfo.isLoggedIn = true;
    // Simpan
    await loginInfo.saveToSharedPreferences();
  }
}
