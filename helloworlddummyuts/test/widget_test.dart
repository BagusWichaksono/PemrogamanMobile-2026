import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:helloworlddummyuts/main.dart';

void main() {
  testWidgets('Hello World test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Teks Hello World! belum tampil saat aplikasi dibuka
    expect(find.text('Hello World!'), findsNothing);

    // Terdapat tepat satu tombol
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Klik tombol
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Teks Hello World! tampil di layar setelah diklik
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
