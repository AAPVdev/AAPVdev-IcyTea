import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'marker_data.dart';

class MapWidget extends StatelessWidget {
  final LatLng currentPosition;
  final List<MarkerData> markers;
  final Function(LatLng) onMapTapped;

  const MapWidget({
    required this.currentPosition,
    required this.markers,
    required this.onMapTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onTap: (tapPosition, latLng) => onMapTapped(latLng),
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: currentPosition,
              width: 80.0,
              height: 80.0,
              child: Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 40.0,
              ),
            ),
            ...markers.map((markerData) {
              return Marker(
                point: markerData.position,
                width: 80.0,
                height: 80.0,
                child: GestureDetector(
                  onTap: () => onMapTapped(markerData.position),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blueAccent,
                    size: 40.0,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
