import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mydj/data/data_provider.dart';
import 'package:mydj/pages/detail_jurnal_page.dart';

class LihatJurnalPage extends StatefulWidget {
  const LihatJurnalPage({super.key, this.title = 'Lihat Jurnal'});
  final String title;

  @override
  State<LihatJurnalPage> createState() => _LihatJurnalPageState();
}

class _LihatJurnalPageState extends State<LihatJurnalPage> {
  @override
  void initState() {
    super.initState();
    // Muat jurnal dari SQLite sekali saja saat halaman dibuka
    context.read<DataProvider>().muatJurnal();
  }

  @override
  Widget build(BuildContext context) {
    final daftarJurnal = context.watch<DataProvider>().jurnalTersimpan;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: daftarJurnal.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Text(daftarJurnal[index].kelas),
                  subtitle: Text(
                    '${daftarJurnal[index].mapel}\n${daftarJurnal[index].createdAt}',
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      final id = daftarJurnal[index].id;
                      if (id != null) {
                        context.read<DataProvider>().hapusJurnal(id);
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailJurnalPage(jurnal: daftarJurnal[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
