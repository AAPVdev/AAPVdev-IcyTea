import 'dart:async';
import 'package:noise_meter/noise_meter.dart';

class NoiseService {
  NoiseMeter? _noiseMeter;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  final List<double> _recordedDecibels = [];

  void startRecording(void Function(double) onUpdate, void Function() onStop) {
    _noiseMeter = NoiseMeter();
    _noiseSubscription = _noiseMeter!.noise.listen((noiseReading) {
      onUpdate(noiseReading.meanDecibel);
      _recordedDecibels.add(noiseReading.meanDecibel);
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_recordedDecibels.length >= 300) {
        _stopRecording(onStop);
      }
    });
  }

  void _stopRecording(void Function() onStop) {
    _noiseSubscription?.cancel();
    onStop();
  }

  double get averageDecibel =>
      _recordedDecibels.reduce((a, b) => a + b) / _recordedDecibels.length;
}