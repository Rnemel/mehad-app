import 'package:flutter/material.dart';

class MapPinWidget extends StatelessWidget {
  final String variant; // 'warning', 'error'

  const MapPinWidget({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    final color = variant == 'warning' ? const Color(0xFFFF9800) : const Color(0xFFD4000F);
    
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).round()),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.location_on,
          size: 60,
          color: color,
        ),
      ),
    );
  }
}
