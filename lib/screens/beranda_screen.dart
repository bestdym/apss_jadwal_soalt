import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import '../services/location_service.dart';
import '../services/prayer_time_service.dart';
import 'dart:async';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  String _locationName = 'Mencari lokasi...';
  PrayerTimes? _prayerTimes;
  Prayer? _nextPrayer;
  Duration _timeUntilNextPrayer = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      Position? position = await LocationService.getCurrentPosition();
      if (position != null) {
        String address = await LocationService.getAddressFromLatLng(position);
        PrayerTimes times = PrayerTimeService.getPrayerTimes(
          position.latitude,
          position.longitude,
          DateTime.now(),
        );

        if (mounted) {
          setState(() {
            _locationName = address;
            _prayerTimes = times;
            _nextPrayer = times.nextPrayer();
          });
          _startCountdown();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _locationName = 'Gagal mendapat lokasi';
        });
      }
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_prayerTimes != null && _nextPrayer != null && _nextPrayer != Prayer.none) {
        DateTime nextTime = _prayerTimes!.timeForPrayer(_nextPrayer!)!;
        setState(() {
          _timeUntilNextPrayer = nextTime.difference(DateTime.now());
          if (_timeUntilNextPrayer.isNegative) {
            // Refresh schedule if prayer time passed
            _nextPrayer = _prayerTimes!.nextPrayer();
          }
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return "00:00:00";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "-${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _getPrayerName(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr: return 'Subuh';
      case Prayer.sunrise: return 'Terbit';
      case Prayer.dhuhr: return 'Dzuhur';
      case Prayer.asr: return 'Ashar';
      case Prayer.maghrib: return 'Maghrib';
      case Prayer.isha: return 'Isya';
      default: return 'Tidak diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Location and Profile
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Color(0xFF10463A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _locationName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF10463A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 18,
                    child: const Icon(Icons.person_outline, color: Color(0xFF10463A), size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Date section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jadwal Hari Ini',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: const Icon(Icons.calendar_today_outlined, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Next Prayer Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF10463A),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10463A).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'MENUJU SHOLAT BERIKUTNYA',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _nextPrayer != null && _nextPrayer != Prayer.none 
                          ? _getPrayerName(_nextPrayer!) 
                          : 'Selesai',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (_prayerTimes != null && _nextPrayer != null && _nextPrayer != Prayer.none)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            PrayerTimeService.formatTime(_prayerTimes!.timeForPrayer(_nextPrayer!)!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'WIB', // TODO: adjust timezone dynamically
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _formatDuration(_timeUntilNextPrayer),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'JADWAL HARI INI',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),

              // Schedule Items
              if (_prayerTimes == null)
                const Center(child: CircularProgressIndicator())
              else ...[
                _buildScheduleItem('Imsak', PrayerTimeService.formatTime(_prayerTimes!.fajr.subtract(const Duration(minutes: 10))), isActive: _nextPrayer == Prayer.fajr), // Mock Imsak
                _buildScheduleItem('Subuh', PrayerTimeService.formatTime(_prayerTimes!.fajr), isActive: _nextPrayer == Prayer.fajr),
                _buildScheduleItem('Terbit', PrayerTimeService.formatTime(_prayerTimes!.sunrise), isActive: _nextPrayer == Prayer.sunrise),
                _buildScheduleItem('Dzuhur', PrayerTimeService.formatTime(_prayerTimes!.dhuhr), isActive: _nextPrayer == Prayer.dhuhr),
                _buildScheduleItem('Ashar', PrayerTimeService.formatTime(_prayerTimes!.asr), isActive: _nextPrayer == Prayer.asr),
                _buildScheduleItem('Maghrib', PrayerTimeService.formatTime(_prayerTimes!.maghrib), isActive: _nextPrayer == Prayer.maghrib),
                _buildScheduleItem('Isya', PrayerTimeService.formatTime(_prayerTimes!.isha), isActive: _nextPrayer == Prayer.isha),
              ],
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String name, String time, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isActive
            ? Border.all(color: const Color(0xFF10463A).withOpacity(0.3), width: 1)
            : null,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          if (isActive) ...[
            const Icon(Icons.mosque, color: Color(0xFF10463A), size: 20),
            const SizedBox(width: 12),
          ],
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? const Color(0xFF10463A) : Colors.black87,
            ),
          ),
          const Spacer(),
          if (isActive) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'SELANJUTNYA',
                style: TextStyle(
                  color: Color(0xFFE65100),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              color: isActive ? const Color(0xFF10463A) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
