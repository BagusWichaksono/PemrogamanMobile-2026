import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mydj/data/data_provider.dart';
import 'package:mydj/pages/startup_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyDJ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D253F), // Biru tua
          primary: const Color(0xFF0D253F), // Biru tua
          inversePrimary: const Color(0xFF1E3A5F), // Biru tua untuk AppBar
          secondary: Colors.black, // Hitam
          surface: const Color(0xFFF5F7FA), // Abu-abu
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Abu-abu terang
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A5F), // Biru tua
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D253F), // Biru tua
            foregroundColor: Colors.white,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF0D253F), // Biru tua
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const StartupPage(),
    );
  }
}
