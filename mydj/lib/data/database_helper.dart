import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton: hanya ada satu objek DatabaseHelper di seluruh aplikasi
  static final DatabaseHelper instance = DatabaseHelper._();
  DatabaseHelper._();

  Database? _db;

  // Database dibuka hanya jika belum pernah dibuka
  Future<Database> get database async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    // Lokasi folder database di perangkat + nama file database
    final path = join(await getDatabasesPath(), 'mydj.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Dijalankan sekali saja, yaitu ketika file database pertama kali dibuat
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE jurnal ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'kelas TEXT, '
      'mapel TEXT, '
      'jam INTEGER, '
      'tujuanPembelajaran TEXT, '
      'materiTopikPembelajaran TEXT, '
      'kegiatanPembelajaran TEXT, '
      'dimensiProfilPelajarPancasila TEXT, '
      'createdAt TEXT)',
    );

    // Data awal sesuai dengan screenshot Pertemuan 12 halaman 8
    await db.insert('jurnal', {
      'kelas': 'TI-3A',
      'mapel': 'Pemrograman Mobile',
      'jam': 1,
      'tujuanPembelajaran': 'Mempelajari dasar widget formulir',
      'materiTopikPembelajaran': 'Dasar Widget',
      'kegiatanPembelajaran': 'Praktik membuat input dan validasi',
      'dimensiProfilPelajarPancasila': 'Mandiri, Bernalar Kritis',
      'createdAt': '2026-11-12 07:39:58.509987',
    });
    await db.insert('jurnal', {
      'kelas': 'TI-3B',
      'mapel': 'Pemrograman Mobile',
      'jam': 2,
      'tujuanPembelajaran': 'Persistensi data lokal dengan SQLite',
      'materiTopikPembelajaran': 'Persistensi SQLite',
      'kegiatanPembelajaran': 'Praktik CRUD data jurnal',
      'dimensiProfilPelajarPancasila': 'Mandiri, Bernalar Kritis',
      'createdAt': '2026-11-12 07:40:17.358077',
    });
  }
}
