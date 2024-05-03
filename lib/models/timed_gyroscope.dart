import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class TimedGyroscopeEvent {
  final GyroscopeEvent event;
  final DateTime timestamp;

  TimedGyroscopeEvent(this.event) : timestamp = DateTime.now();
}
