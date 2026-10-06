import 'package:flutter/material.dart';

import 'mahasiswa.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nim = TextEditingController(); // setara EditText
  final _nama = TextEditingController();
  final _prodi = TextEditingController();
  final _semester = TextEditingController(text: '1');

  @override
  void dispose() {
    // setara onDestroy(): membuang controller
    _nim.dispose();
    _nama.dispose();
    _prodi.dispose();
    _semester.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    final baru = Mahasiswa(
      nim: _nim.text.trim(),
      nama: _nama.text.trim(),
      prodi: _prodi.text.trim(),
      semester: int.parse(_semester.text),
    );
    // setara setResult(RESULT_OK, intent); finish();
    Navigator.pop(context, baru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Mahasiswa')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nim,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'NIM wajib diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nama,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _prodi,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Program Studi',
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Program Studi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _semester,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Semester (1-8)',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final s = int.tryParse(v ?? '');
                if (s == null || s < 1 || s > 8) return 'Isi angka 1 sampai 8';
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save),
              label: const Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
  }
}
