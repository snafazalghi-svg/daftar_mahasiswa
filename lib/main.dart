import 'package:flutter/material.dart';

import 'mahasiswa.dart';
import 'form_page.dart';
import 'detail_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Mahasiswa',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const DaftarPage(),
    ),
  );
}

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final List<Mahasiswa> _data = []; // data (setara ArrayList di Adapter)
  bool _loading = true;

  @override
  void initState() {
    super.initState(); // setara onCreate()
    _muatData();
  }

  // Simulasi mengambil data dari server/database selama 2 detik.
  Future<void> _muatData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _data.addAll(const [
        Mahasiswa(
          nim: 'E32241001',
          nama: 'Andi Pratama',
          prodi: 'Teknik Komputer',
          semester: 3,
        ),
        Mahasiswa(
          nim: 'E32241002',
          nama: 'Budi Santoso',
          prodi: 'Teknik Komputer',
          semester: 3,
        ),
        Mahasiswa(
          nim: 'E32241003',
          nama: 'Citra Lestari',
          prodi: 'Teknik Komputer',
          semester: 3,
        ),
      ]);
      _loading = false;
    });
  }

  // setara startActivityForResult() + onActivityResult()
  Future<void> _tambah() async {
    final baru = await Navigator.push<Mahasiswa>(
      context,
      MaterialPageRoute(builder: (_) => const FormPage()),
    );
    if (baru == null || !mounted) return; // kembali tanpa menyimpan
    setState(() => _data.add(baru));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${baru.nama} ditambahkan')));
  }

  void _hapus(int index) {
    final m = _data[index];
    setState(() => _data.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${m.nama} dihapus'),
        action: SnackBarAction(
          label: 'BATAL',
          onPressed: () => setState(() => _data.insert(index, m)),
        ),
      ),
    );
  }

  Widget _isi() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_data.isEmpty) {
      return const Center(child: Text('Belum ada data'));
    }
    // setara RecyclerView + Adapter
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, i) {
        final m = _data[i];
        return Dismissible(
          key: ObjectKey(m),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => _hapus(i),
          child: ListTile(
            leading: CircleAvatar(child: Text(m.inisial)),
            title: Text(m.nama),
            subtitle: Text('${m.nim} • ${m.prodi} • Semester ${m.semester}'),
            // setara Intent explicit + putExtra()
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage(mahasiswa: m)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Mahasiswa (${_data.length})')),
      body: _isi(),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}
