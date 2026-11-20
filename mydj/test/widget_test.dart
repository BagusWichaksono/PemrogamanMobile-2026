import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:mydj/data/data_provider.dart';
import 'package:mydj/data/jurnal.dart';
import 'package:mydj/data/login_info.dart';
import 'package:mydj/main.dart';
import 'package:mydj/pages/detail_jurnal_page.dart';
import 'package:mydj/pages/lihat_jurnal_page.dart';
import 'package:mydj/pages/tentang_aplikasi_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Pertemuan 10 & 11 - LoginInfo & Authentication', () {
    test('LoginInfo save, load, and delete from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});

      LoginInfo info = LoginInfo(
        username: 'guru',
        password: 'secretpassword',
        isLoggedIn: true,
      );
      await info.saveToSharedPreferences();

      LoginInfo loaded = await LoginInfo.fromSharedPreferences();
      expect(loaded.username, 'guru');
      expect(loaded.password, 'secretpassword');
      expect(loaded.isLoggedIn, true);

      await LoginInfo.deleteFromSharedPreferences();
      LoginInfo deleted = await LoginInfo.fromSharedPreferences();
      expect(deleted.username, '');
      expect(deleted.password, '');
      expect(deleted.isLoggedIn, false);
    });

    testWidgets('App displays LoginPage when not logged in', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DataProvider()),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pump();
      await tester.idle();
      await tester.pump();

      expect(find.text('MyDJ - Welcome'), findsOneWidget);
      expect(find.text('Nama Pengguna:'), findsOneWidget);
      expect(find.text('Sandi:'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('App displays HomePage when already logged in', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'username': 'guru',
        'password': 'guru',
        'isLoggedIn': true,
      });

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DataProvider()),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pump();
      await tester.idle();
      await tester.pump();

      expect(find.text('Jurnal Harian Guru'), findsOneWidget);
      expect(find.text('Lihat Jurnal'), findsOneWidget);
      expect(find.text('Buat Jurnal'), findsOneWidget);
    });
  });

  group('Pertemuan 8 & 12 - Jurnal Model toMap and fromMap', () {
    test('Jurnal serialization and deserialization', () {
      final now = DateTime.now();
      final jurnal = Jurnal(
        id: 1,
        kelas: 'TI-3B',
        mapel: 'Pemrograman Mobile',
        jam: 3,
        tujuanPembelajaran: 'Belajar SQLite',
        materiTopikPembelajaran: 'Persistensi Data',
        kegiatanPembelajaran: 'Praktik Coding',
        dimensiProfilPelajarPancasila: 'Mandiri, Bernalar Kritis',
        createdAt: now,
      );

      final map = jurnal.toMap();
      expect(map['id'], 1);
      expect(map['kelas'], 'TI-3B');
      expect(map['mapel'], 'Pemrograman Mobile');
      expect(map['jam'], 3);
      expect(map['tujuanPembelajaran'], 'Belajar SQLite');
      expect(map['materiTopikPembelajaran'], 'Persistensi Data');
      expect(map['kegiatanPembelajaran'], 'Praktik Coding');
      expect(map['dimensiProfilPelajarPancasila'], 'Mandiri, Bernalar Kritis');
      expect(map['createdAt'], now.toIso8601String());

      final restored = Jurnal.fromMap(map);
      expect(restored.id, 1);
      expect(restored.kelas, 'TI-3B');
      expect(restored.mapel, 'Pemrograman Mobile');
      expect(restored.jam, 3);
      expect(restored.createdAt.toIso8601String(), now.toIso8601String());
    });
  });

  group('Ujian Praktik - Tentang Aplikasi', () {
    testWidgets('Tentang Aplikasi: nama, tagline, versi, pembuat, dan URL', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TentangAplikasiPage(),
        ),
      );

      expect(find.text('MyDJ'), findsOneWidget);
      expect(find.text('Aplikasi Jurnal Harian Guru'), findsOneWidget);
      expect(find.textContaining('Version:'), findsOneWidget);
      expect(find.textContaining('Dibuat oleh:'), findsOneWidget);
      expect(find.textContaining('https://'), findsOneWidget);

      await tester.tap(find.textContaining('https://'));
      await tester.pump();
    });
  });

  group('Kuis-2 - Detail dan Edit Jurnal', () {
    testWidgets('DetailJurnalPage menampilkan atribut dan tombol Edit Jurnal Ini', (WidgetTester tester) async {
      final sampleJurnal = Jurnal(
        id: 10,
        kelas: 'TI-3A',
        mapel: 'Pemrograman Mobile',
        jam: 2,
        tujuanPembelajaran: 'Membuat detail jurnal',
        materiTopikPembelajaran: 'Navigasi dan Read-Only',
        kegiatanPembelajaran: 'Praktik widget',
        dimensiProfilPelajarPancasila: 'Mandiri',
      );

      final provider = DataProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: MaterialApp(
            home: DetailJurnalPage(jurnal: sampleJurnal),
          ),
        ),
      );

      expect(find.text('Detail Jurnal'), findsOneWidget);
      expect(find.text('Kelas'), findsOneWidget);
      expect(find.text('Mata Pelajaran'), findsOneWidget);
      expect(find.text('Jam Ke-'), findsOneWidget);
      expect(find.text('Tujuan Pembelajaran'), findsOneWidget);
      expect(find.text('Materi / Topik Pembelajaran'), findsOneWidget);
      expect(find.text('Kegiatan Pembelajaran'), findsOneWidget);
      expect(find.text('Dimensi Profil Pelajar Pancasila'), findsOneWidget);
      expect(find.text('Waktu Dibuat'), findsOneWidget);
      expect(find.text('Edit Jurnal Ini'), findsOneWidget);

      // Scroll until visible then tap Edit Jurnal Ini opens edit page prefilled
      await tester.ensureVisible(find.text('Edit Jurnal Ini'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit Jurnal Ini'));
      await tester.pumpAndSettle();

      expect(find.text('TI-3A'), findsOneWidget);
      expect(find.text('Simpan'), findsOneWidget);
    });

    test('DataProvider memiliki fungsi ubahJurnal', () async {
      final provider = DataProvider();
      final sample = Jurnal(
        id: 99,
        kelas: 'TI-1A',
        mapel: 'Dasar Pemrograman',
      );
      provider.jurnalTersimpan.add(sample);

      sample.kelas = 'TI-1B';
      await provider.ubahJurnal(sample);

      expect(provider.jurnalTersimpan.firstWhere((j) => j.id == 99).kelas, 'TI-1B');
    });

    testWidgets('Ketuk baris Lihat Jurnal membuka halaman detail', (WidgetTester tester) async {
      final provider = DataProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: const MaterialApp(
            home: LihatJurnalPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap first ListTile
      expect(find.byType(ListTile), findsWidgets);
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      // Should be on DetailJurnalPage
      expect(find.byType(DetailJurnalPage), findsOneWidget);
      expect(find.text('Edit Jurnal Ini'), findsOneWidget);
    });
  });
}
