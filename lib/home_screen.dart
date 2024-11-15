import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:noise_meter/noise_meter.dart';
import 'marker_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late MapController _mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0);  // Default to a fallback position
  bool _locationGranted = false;
  double _currentDecibel = 0.0;
  double? _averageDecibel;
  bool _isRecording = false;
  final List<double> _recordedDecibels = [];
  Timer? _recordingTimer;
  int _elapsedTime = 0;
  NoiseMeter? _noiseMeter;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  final List<MarkerData> _markers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _checkPermissions();
    _noiseMeter = NoiseMeter();
  }

  Future<void> _checkPermissions() async {
    var location = Location();
    PermissionStatus status = await location.requestPermission();
    if (status == PermissionStatus.granted) {
      _locationGranted = true;
      _getCurrentLocation();
    } else {
      // Handle permission denied scenario
    }
  }

  Future<void> _getCurrentLocation() async {
    if (_locationGranted) {
      Location location = Location();
      LocationData currentLocation = await location.getLocation();
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      } else {
        // Fallback to a default location if location is unavailable
        setState(() {
          _currentPosition = LatLng(37.7749, -122.4194); // San Francisco as fallback
        });
      }

      // Use MapController.move to set the map center and zoom level
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.move(_currentPosition, 14.0); // Set the zoom level and center
      });
    }
  }

  void _startStopRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    if (_noiseMeter == null) return;

    setState(() {
      _isRecording = true;
      _recordedDecibels.clear();
      _averageDecibel = null;
      _elapsedTime = 0;
    });

    _noiseSubscription = _noiseMeter!.noise.listen((noiseReading) {
      setState(() {
        _currentDecibel = noiseReading.meanDecibel;
        _recordedDecibels.add(_currentDecibel);
        _averageDecibel = _recordedDecibels.reduce((a, b) => a + b) / _recordedDecibels.length;
      });
    });

    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });

      if (_elapsedTime >= 300) {
        _stopRecording();
      }
    });
  }

  void _stopRecording() {
    _noiseSubscription?.cancel();
    setState(() {
      _isRecording = false;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Recording Complete"),
        content: Text("Average Decibel: ${_averageDecibel?.toStringAsFixed(1) ?? 'N/A'} dB"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _onMapTapped(LatLng tappedLocation) async {
    bool? shouldCheck = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Check Average Decibel"),
        content: const Text("Do you want to check the average decibel at this location?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
        ],
      ),
    );

    if (shouldCheck == true) {
      setState(() {
        _markers.add(MarkerData(
          position: tappedLocation,
          decibel: 65.0,  // Example decibel value, you can replace this with actual calculation
        ));
      });
    }
  }

  void _showMarkerDetails(MarkerData markerData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Marker Details"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Location: ${markerData.position.latitude}, ${markerData.position.longitude}"),
            Text("Average Decibel: ${markerData.decibel.toStringAsFixed(1)} dB"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _markers.remove(markerData);
              });
              Navigator.of(context).pop();
            },
            child: const Text("Delete Marker"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    _recordingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          if (_locationGranted) FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              onTap: (tapPosition, latLng) => _onMapTapped(latLng), // Handle map tap
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",  // OpenStreetMap tiles
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,  // Current position marker
                    width: 80.0,
                    height: 80.0,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40.0,
                    ),
                  ),
                  ..._markers.map((markerData) {
                    return Marker(
                      point: markerData.position,
                      width: 80.0,
                      height: 80.0,
                      child: GestureDetector(
                        onTap: () {
                          _showMarkerDetails(markerData); // Show details on marker tap
                        },
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
          ) else const Center(child: CircularProgressIndicator()),

          // Show the current and average decibel values during recording
          if (_isRecording)
            Positioned(
              top: 100,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Decibel: ${_currentDecibel.toStringAsFixed(1)} dB',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Average Decibel: ${_averageDecibel?.toStringAsFixed(1) ?? 'N/A'} dB',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _startStopRecording,
              backgroundColor: _isRecording ? Colors.green : Colors.redAccent,
              tooltip: _isRecording ? "Stop Recording" : "Start Recording",
              child: Icon(_isRecording ? Icons.stop : Icons.mic),
            ),
          ),
        ],
      ),
    );
  }
}
