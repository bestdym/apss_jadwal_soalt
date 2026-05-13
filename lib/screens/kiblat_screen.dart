import 'package:flutter/material.dart';

class KiblatScreen extends StatelessWidget {
  const KiblatScreen({super.key});

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
                  const Text(
                    'Jakarta, Indonesia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF10463A),
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 18,
                    child: const Icon(Icons.person_outline, color: Color(0xFF10463A), size: 20),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'Arah kiblat berpusat pada Kaaba',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            
            const SizedBox(height: 64),
            
            // Compass Mock UI
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer ring
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                    ),
                  ),
                  // Inner ring (greenish)
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF1F8F6),
                      border: Border.all(color: const Color(0xFFE8F5E9), width: 1),
                    ),
                  ),
                  // N, S, E, W Markers
                  const Positioned(top: 20, child: Text('U', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                  const Positioned(bottom: 20, child: Text('S', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                  
                  // Kaaba pointer mock
                  Transform.rotate(
                    angle: -0.5, // Mock rotation to North-West
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_upward, size: 40, color: Color(0xFFD4AF37)), // Gold color for Kaaba direction
                        const SizedBox(height: 120), // Distance from center
                      ],
                    ),
                  ),
                  
                  // Center dot
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10463A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // GPS Accuracy Box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.gps_fixed, color: Color(0xFF10463A), size: 20),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Akurasi GPS',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tinggi (± 3 meter)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh, size: 16, color: Color(0xFF10463A)),
                    label: const Text(
                      'Kalibrasi',
                      style: TextStyle(color: Color(0xFF10463A), fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF9FBFB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
