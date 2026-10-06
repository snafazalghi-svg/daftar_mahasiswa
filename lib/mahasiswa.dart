class Mahasiswa {
  final String nim;
  final String nama;
  final String prodi;
  final int semester;

  const Mahasiswa({
    required this.nim,
    required this.nama,
    required this.prodi,
    required this.semester,
  });

  // getter: huruf pertama nama untuk avatar
  String get inisial => nama.isEmpty ? '?' : nama[0].toUpperCase();
}
