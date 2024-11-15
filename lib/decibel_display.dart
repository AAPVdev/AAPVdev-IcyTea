import 'package:flutter/material.dart';
import 'marker_data.dart';

class DecibelDisplay extends StatelessWidget {
  final List<MarkerData> markers;

  const DecibelDisplay({required this.markers, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: markers.map((markerData) {
        return Positioned(
          left: 20.0,  // You can refine this positioning based on your layout
          top: 150.0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              '${markerData.decibel.toStringAsFixed(1)} dB',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}