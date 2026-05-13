# Jadwal Sholat & Arah Kiblat 🕌

Aplikasi Flutter modern yang didesain untuk menampilkan jadwal sholat akurat secara real-time dan penunjuk arah kiblat, sepenuhnya mengikuti lokasi pengguna tanpa memerlukan koneksi database eksternal.

## ✨ Fitur Utama

- **📍 Lokasi Otomatis (GPS)**: Mendeteksi lokasi pengguna secara otomatis menggunakan sensor GPS perangkat (Latitude & Longitude).
- **⏱️ Jadwal Sholat Offline**: Menghitung jadwal sholat akurat (Subuh, Terbit, Dzuhur, Ashar, Maghrib, Isya) secara matematis & astronomis berdasarkan kordinat bumi dan tanggal lokal. Bekerja **100% Offline** tanpa API eksternal.
- **🧭 Arah Kiblat**: Menggunakan sensor kompas *device* untuk menunjuk arah Ka'bah secara akurat sesuai posisi pengguna saat ini.
- **🎨 UI Modern & Clean**: Antarmuka pengguna yang terinspirasi dari desain modern dengan *Bottom Navigation Bar*, dilengkapi halaman Beranda, Kalender bulanan, dan Kompas.
- **⏰ Hitung Mundur (Countdown)**: Informasi cerdas yang menampilkan "Menuju Sholat Berikutnya" dengan hitung mundur detik.

## 🛠️ Teknologi & Packages

Proyek ini dibangun menggunakan [Flutter](https://flutter.dev) dan didukung oleh beberapa *packages* unggulan:

- `geolocator`: Untuk mengakses izin dan kordinat sensor GPS perangkat.
- `geocoding`: Untuk konversi angka Latitude/Longitude menjadi nama Kota dan Negara (Reverse Geocoding).
- `adhan`: *Core engine* perhitungan astronomi sholat lokal. Menggunakan parameter perhitungan Kementerian Agama (metode Singapura/Syafi'i).
- `flutter_compass`: Untuk membaca sensor kompas *hardware* dan *gyroscope*.

## 🚀 Cara Menjalankan Aplikasi

1. **Clone repositori ini:**
   ```bash
   git clone https://github.com/bestdym/apss_jadwal_soalt.git
   cd waktu_solat
   ```

2. **Instal seluruh dependencies:**
   ```bash
   flutter pub get
   ```

3. **Penting (Izin Android):**
   Pastikan Anda tidak menghapus konfigurasi izin lokasi di dalam file `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   ```

4. **Jalankan aplikasi (Gunakan perangkat fisik / Emulator dengan GPS menyala):**
   ```bash
   flutter run
   ```
   *(Catatan: Karena aplikasi menggunakan sensor GPS dan Kompas asli, sangat disarankan menggunakan HP Fisik (Real Device) untuk pengujian agar hasilnya akurat).*

## 📱 Struktur Aplikasi

- **Beranda**: Menampilkan lokasi saat ini, tanggal (Hijriah & Masehi), Jadwal Sholat hari ini, dan penunjuk/hitung mundur waktu sholat selanjutnya.
- **Kalender**: Menampilkan daftar jadwal sholat penuh selama satu bulan dengan indikator "Hari ini".
- **Kiblat**: Tampilan kompas visual dengan indikator panah presisi menuju arah Makkah, dilengkapi pembaca status akurasi GPS perangkat.

---
*Dibuat untuk memudahkan umat muslim mendapatkan jadwal sholat dengan presisi tinggi di mana pun mereka berada.*
