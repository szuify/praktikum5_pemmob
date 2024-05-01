import 'dart:convert';
import 'dart:io';

void main() {
  String transkripJson = File('transkrip.json').readAsStringSync();

  Map<String, dynamic> transkrip = jsonDecode(transkripJson);

  double ipk = calculateIPK(transkrip);
  int totalSKS = calculateTotalSKS(transkrip);

  print('IPK dari ${transkrip['nama']} adalah $ipk');
  print('Total SKS Kumulatif: $totalSKS');
}

double calculateIPK(Map<String, dynamic> transkrip) {
  List<dynamic> mataKuliah = transkrip['mata_kuliah'];
  int totalSKS = 0;
  double totalBobot = 0;

  for (var matkul in mataKuliah) {
    int sks = matkul['sks'];
    totalSKS += sks;

    String nilai = matkul['nilai'];
    double bobot = nilaiToBobot(nilai);
    totalBobot += bobot * sks;
  }

  return totalBobot / totalSKS;
}

int calculateTotalSKS(Map<String, dynamic> transkrip) {
  List<dynamic> mataKuliah = transkrip['mata_kuliah'];
  int totalSKS = 0;

  for (var matkul in mataKuliah) {
    int sks = matkul['sks'];
    totalSKS += sks;
  }

  return totalSKS;
}

double nilaiToBobot(String nilai) {
  switch (nilai) {
    case 'A':
      return 4.0;
    case 'A-':
      return 3.7;
    case 'B+':
      return 3.3;
    case 'B':
      return 3.0;
    case 'B-':
      return 2.7;
    case 'C+':
      return 2.3;
    case 'C':
      return 2.0;
    case 'C-':
      return 1.7;
    case 'D':
      return 1.0;
    case 'E':
      return 0.0;
    default:
      return 0.0;
  }
}
