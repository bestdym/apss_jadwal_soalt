# Jadwal Sholat & Arah Kiblat 🕌

Aplikasi Flutter modern yang didesain untuk menampilkan jadwal sholat akurat secara real-time dan penunjuk arah kiblat, sepenuhnya mengikuti lokasi pengguna tanpa memerlukan koneksi database eksternal.

## ✨ Fitur Utama (Real-Time)

- **📍 Lokasi Otomatis (GPS)**: Mendeteksi nama kota dan negara Anda secara otomatis menggunakan koordinat GPS (*Geolocator* & *Geocoding*).
- **⏱️ Jadwal Sholat Dinamis**: Menghitung jadwal sholat (Subuh, Terbit, Dzuhur, Ashar, Maghrib, Isya) berdasarkan astronomi lokasi persis Anda menggunakan metode Kemenag (Singapura/Syafi'i). 100% *Offline*.
- **⏰ Hitung Mundur (Countdown)**: Sistem pengingat waktu cerdas yang menghitung mundur detik demi detik menuju waktu sholat berikutnya secara *real-time*. Jika waktu habis, akan otomatis berpindah ke jadwal sholat selanjutnya.
- **📅 Kalender Interaktif**: Halaman kalender bulanan dengan tombol geser bulan (Prev/Next Month) yang akan merender ulang seluruh jadwal sholat selama satu bulan secara akurat.
- **🧭 Arah Kiblat**: Menggunakan sensor kompas HP (*hardware magnetometer/gyroscope*) untuk selalu menunjuk presisi ke arah Ka'bah (Makkah).

## 🛠️ Teknologi & Packages

Proyek ini menggunakan *Tech Stack* modern berbasis [Flutter](https://flutter.dev) tanpa membutuhkan Database:

- `geolocator`: Untuk mengakses izin dan kordinat sensor GPS perangkat.
- `geocoding`: Untuk mengubah angka Latitude/Longitude menjadi nama Kota (Misal: "Jakarta, Indonesia").
- `adhan`: *Core engine* perhitungan astronomi sholat berbasis titik koordinat bumi.
- `flutter_compass`: Untuk membaca orientasi sensor kompas secara akurat.

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
   Aplikasi membutuhkan izin akses GPS bawaan. Konfigurasi ini sudah tertanam di `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   ```

4. **Jalankan aplikasi:**
   *(Gunakan perangkat fisik (HP Asli) untuk melihat hitung mundur dan GPS yang akurat. Emulator tidak disarankan karena tidak memiliki sensor kompas fisik).*
   ```bash
   flutter run
   ```

## 📱 Struktur Aplikasi

- **Beranda**: Halaman utama berisi nama kota saat ini, tanggal, jadwal full hari ini, dan **Hitung Mundur Live** sholat berikutnya.
- **Kalender**: Menampilkan daftar sholat penuh sebulan. Dilengkapi fitur *shift* bulan (Bisa digeser untuk melihat bulan depan/lalu).
- **Kiblat**: Tampilan visual kompas dengan indikator menuju arah Ka'bah dan tingkat akurasi satelit GPS.

---
*Dikembangkan tanpa backend (Serverless). Sangat cepat, hemat baterai, dan bisa diandalkan bahkan tanpa koneksi internet!*
