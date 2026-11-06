import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Formulir Pendaftaran'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Variabel
  String _nim = '';

  void _tampilkanPesan(BuildContext context) {
    String pesan = 'NIM ${_nim} sudah terdaftar!';
    SnackBar snackBar = SnackBar(
        content: Text(pesan)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              //Text("NIM: "),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Masukkan NIM Anda.'
                  ),
                onChanged: (value) => {
                    setState(() {
                      _nim = value;
                    })
                },
              ),
              SizedBox(
                height: 20,
              ),
              //Nama
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Masukkan Nama Anda.'
                  )
              ),
              SizedBox(
                height: 20,
              ),
              //Alamat
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Alamat Anda.'
                ),
                maxLines: 4,
              ),
              SizedBox(
                height: 20,
              ),
              //Alasan Mendaftar
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Alasan Mendaftar Anda.'
                ),
                maxLines: 4,
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pilih Jurusan Anda.'
                  ),
                  items: [
                    DropdownMenuItem(value: 'jti', child: Text('Teknologi Informasi')),
                    DropdownMenuItem(value: 'jtm', child: Text('Teknik Mesin')),
                    DropdownMenuItem(value: 'jan', child: Text('Administrasi Niaga')),
                  ],
                  onChanged: (value) => {}
              ),
              SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Saya telah membaca dan menyetujui syarat dan ketentuan yang berlaku.'),
                  value: false,
                  onChanged: (value) => {}
              ),
              SizedBox(
                height: 20,
              ),
              //Button Daftar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => {
                      _tampilkanPesan(context)
                    },
                    child: Text('Daftar'),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
