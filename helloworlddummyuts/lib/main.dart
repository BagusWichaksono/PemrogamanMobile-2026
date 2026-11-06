import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HelloWorldScreen(),
    );
  }
}

class HelloWorldScreen extends StatefulWidget {
  const HelloWorldScreen({super.key});

  @override
  State<HelloWorldScreen> createState() => _HelloWorldScreenState();
}

class _HelloWorldScreenState extends State<HelloWorldScreen> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isClicked = true;
                });
              },
              child: const Text('Tekan Saya'),
            ),
            if (_isClicked) ...[
              const SizedBox(height: 16),
              const Text('Hello World!'),
            ],
          ],
        ),
      ),
    );
  }
}
