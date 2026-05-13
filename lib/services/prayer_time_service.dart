import 'package:adhan/adhan.dart';

class PrayerTimeService {
  // Fungsi untuk mendapatkan semua jadwal sholat hari ini
  static PrayerTimes getPrayerTimes(double lat, double lng, DateTime date) {
    // 1. Masukkan koordinat lokasi pengguna
    final coordinates = Coordinates(lat, lng);
    
    // 2. Tentukan parameter perhitungannya
    // Di Indonesia (Kemenag), standar perhitungannya mirip dengan Singapura 
    // (Sudut Subuh 20 derajat, Isya 18 derajat)
    final params = CalculationMethod.singapore.getParameters();
    
    // Mayoritas di Indonesia menggunakan Mazhab Syafi'i untuk menentukan bayangan waktu Ashar
    params.madhab = Madhab.shafi; 
    
    // 3. Masukkan komponen tanggal (tahun, bulan, hari)
    final dateComponents = DateComponents(date.year, date.month, date.day);
    
    // 4. Hitung dan kembalikan semua jadwal sholat
    return PrayerTimes(coordinates, dateComponents, params);
  }

  // Fungsi opsional untuk format waktu ke String (misal: "18:05")
  static String formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
