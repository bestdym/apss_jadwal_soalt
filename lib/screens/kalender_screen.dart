import 'package:flutter/material.dart';

class KalenderScreen extends StatelessWidget {
  const KalenderScreen({super.key});

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
                children: const [
                  Icon(Icons.location_on_outlined, color: Color(0xFF10463A)),
                  SizedBox(width: 8),
                  Text(
                    'Jakarta, Indonesia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF10463A),
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
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: const [
                          Icon(Icons.calendar_month, color: Color(0xFF10463A), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Februari 2026',
                            style: TextStyle(
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
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Ramadan 1447 H',
                      style: TextStyle(
                        color: Color(0xFF10463A),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Days List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                children: [
                  _buildDayCard(
                    date: '19',
                    day: 'Kamis',
                    hijri: 'Ramadan 1',
                    isToday: false,
                    schedules: ['04:41', '05:53', '12:04', '15:10', '18:08', '19:17'],
                  ),
                  _buildDayCard(
                    date: '20',
                    day: "Jum'at",
                    hijri: 'Ramadan 2',
                    isToday: true,
                    activeScheduleIndex: 3, // Ashar
                    schedules: ['04:40', '05:53', '12:03', '15:11', '18:07', '19:16'],
                  ),
                  _buildDayCard(
                    date: '21',
                    day: 'Sabtu',
                    hijri: 'Ramadan 3',
                    isToday: false,
                    schedules: ['04:40', '05:53', '12:03', '15:11', '18:07', '19:16'],
                  ),
                  _buildDayCard(
                    date: '22',
                    day: 'Minggu',
                    hijri: 'Ramadan 4',
                    isToday: false,
                    schedules: ['04:40', '05:52', '12:03', '15:11', '18:06', '19:15'],
                  ),
                  const SizedBox(height: 24),
                ],
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
    required String hijri,
    required bool isToday,
    int? activeScheduleIndex,
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
                    color: Color(0xFFFFB300), // Yellow dot
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
              Text(
                hijri,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              if (isToday) ...[
                const SizedBox(width: 8),
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
            ],
          ),
          const SizedBox(height: 16),
          // Schedule Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeColumn('Subuh', schedules[0], isActive: activeScheduleIndex == 0),
              _buildTimeColumn('Terbit', schedules[1], isActive: activeScheduleIndex == 1),
              _buildTimeColumn('Dzuhur', schedules[2], isActive: activeScheduleIndex == 2),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeColumn('Ashar', schedules[3], isActive: activeScheduleIndex == 3, isHighlight: isToday && activeScheduleIndex == 3),
              _buildTimeColumn('Maghrib', schedules[4], isActive: activeScheduleIndex == 4),
              _buildTimeColumn('Isya', schedules[5], isActive: activeScheduleIndex == 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time, {bool isActive = false, bool isHighlight = false}) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isHighlight ? const Color(0xFFFFF8E1) : (isActive ? Colors.grey[100] : Colors.transparent),
        borderRadius: BorderRadius.circular(12),
        border: isHighlight ? Border.all(color: const Color(0xFFFFCC80)) : Border.all(color: Colors.grey.shade100),
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlight || isActive ? FontWeight.bold : FontWeight.w600,
              color: isHighlight ? const Color(0xFFE65100) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
