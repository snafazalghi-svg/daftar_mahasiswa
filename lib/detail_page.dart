import 'package:flutter/material.dart';

import 'mahasiswa.dart';

class DetailPage extends StatelessWidget {
  final Mahasiswa mahasiswa; // data dikirim lewat constructor

  const DetailPage({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                child: Text(
                  mahasiswa.inisial,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _baris('Nama', mahasiswa.nama),
            _baris('NIM', mahasiswa.nim),
            _baris('Program Studi', mahasiswa.prodi),
            _baris('Semester', '${mahasiswa.semester}'),
          ],
        ),
      ),
    );
  }

  Widget _baris(String label, String isi) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(isi, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
