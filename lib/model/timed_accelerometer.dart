import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class TimedAccelerometerEvent {
  final AccelerometerEvent event;
  final DateTime timestamp;

  TimedAccelerometerEvent(this.event) : timestamp = DateTime.now();
}
