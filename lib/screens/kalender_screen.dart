import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import '../services/location_service.dart';
import '../services/prayer_time_service.dart';

class KalenderScreen extends StatefulWidget {
  const KalenderScreen({super.key});

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  String _locationName = 'Mencari lokasi...';
  Position? _currentPosition;
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    try {
      Position? position = await LocationService.getCurrentPosition();
      if (position != null) {
        String address = await LocationService.getAddressFromLatLng(position);
        if (mounted) {
          setState(() {
            _currentPosition = position;
            _locationName = address;
          });
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

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  String _getMonthName(int month) {
    const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return months[month - 1];
  }

  String _getDayName(int weekday) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jum\'at', 'Sabtu', 'Minggu'];
    return days[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
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
                ],
              ),
            ),
            
            // Month Selector
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left, size: 20),
                          onPressed: _previousMonth,
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, color: Color(0xFF10463A), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_right, size: 20),
                          onPressed: _nextMonth,
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Days List
            Expanded(
              child: _currentPosition == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      itemCount: DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month),
                      itemBuilder: (context, index) {
                        int day = index + 1;
                        DateTime date = DateTime(_currentMonth.year, _currentMonth.month, day);
                        bool isToday = date.year == DateTime.now().year && date.month == DateTime.now().month && date.day == DateTime.now().day;
                        
                        PrayerTimes pt = PrayerTimeService.getPrayerTimes(_currentPosition!.latitude, _currentPosition!.longitude, date);
                        List<String> schedules = [
                          PrayerTimeService.formatTime(pt.fajr),
                          PrayerTimeService.formatTime(pt.sunrise),
                          PrayerTimeService.formatTime(pt.dhuhr),
                          PrayerTimeService.formatTime(pt.asr),
                          PrayerTimeService.formatTime(pt.maghrib),
                          PrayerTimeService.formatTime(pt.isha),
                        ];

                        return _buildDayCard(
                          date: day.toString(),
                          day: _getDayName(date.weekday),
                          isToday: isToday,
                          schedules: schedules,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard({
    required String date,
    required String day,
    required bool isToday,
    required List<String> schedules,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: isToday ? Border.all(color: const Color(0xFF10463A).withOpacity(0.3), width: 1) : null,
      ),
      child: Column(
        children: [
          // Card Header
          Row(
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isToday ? const Color(0xFF10463A) : Colors.black87,
                ),
              ),
              if (isToday) ...[
                const SizedBox(width: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFB300),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
              const SizedBox(width: 8),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              if (isToday)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Hari ini',
                    style: TextStyle(
                      color: Color(0xFF10463A),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Schedule Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeColumn('Subuh', schedules[0]),
              _buildTimeColumn('Terbit', schedules[1]),
              _buildTimeColumn('Dzuhur', schedules[2]),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeColumn('Ashar', schedules[3]),
              _buildTimeColumn('Maghrib', schedules[4]),
              _buildTimeColumn('Isya', schedules[5]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
