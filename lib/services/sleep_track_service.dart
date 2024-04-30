import 'dart:async';
import 'package:health_app/models/timed_accelerometer.dart';
import 'package:health_app/models/timed_gyroscope.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:logger/logger.dart';

// Constants
const double kInactivityThreshold = 0.2; // m/s^2 (adjust as needed)
const int kInactivityDurationSeconds = 10; // 15 minutes
const double kSignificantMovementThreshold =
    1.0; // m/s^2 or rad/s (adjust as needed)

class SleepTracker {
  final Logger _logger = Logger();
  // Stream subscriptions
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  // Sleep tracking variables
  bool _isSleeping = false;
  DateTime? _sleepStartTime;
  // List<AccelerometerEvent> _recentAccelerometerEvents = [];
  List<TimedAccelerometerEvent> _recentAccelerometerEvents = [];
  // List<GyroscopeEvent> _recentGyroscopeEvents = [];
  List<TimedGyroscopeEvent> _recentGyroscopeEvents = [];

  SleepTracker() {
    // Start listening to sensor events
    _accelerometerSubscription = accelerometerEvents.listen(
      _handleAccelerometerEvent,
      onError: _handleSensorError,
    );
    _gyroscopeSubscription = gyroscopeEvents.listen(
      _handleGyroscopeEvent,
      onError: _handleSensorError,
    );
  }

  void _handleSensorError(dynamic error) {
    print('Sensor Error: $error');
    // Handle sensor error gracefully, e.g., disable sleep tracking, show a user-friendly message, etc.
  }

  // Getters and Setters
  bool get isSleeping => _isSleeping;
  DateTime? get sleepStartTime => _sleepStartTime;
  List<TimedAccelerometerEvent> get recentAccelerometerEvents =>
      _recentAccelerometerEvents;
  List<TimedGyroscopeEvent> get recentGyroscopeEvents => _recentGyroscopeEvents;

  void _handleAccelerometerEvent(AccelerometerEvent event) {
    // _logger.d('Received accelerometer event: $event');
    _recentAccelerometerEvents.add(TimedAccelerometerEvent(event));
    _recentAccelerometerEvents.removeWhere((e) => e.timestamp.isBefore(
        DateTime.now()
            .subtract(const Duration(seconds: kInactivityDurationSeconds))));
    if (!_isSleeping) {
      // Check for prolonged inactivity
      if (_isInactive(_recentAccelerometerEvents)) {
        // Start sleep tracking if no significant movement
        _isSleeping = true;
        _sleepStartTime = DateTime.now();
        _logger.i('Sleep started at $_sleepStartTime');
      }
    } else {
      // Check for wake-up event
      if (_isSignificantAcceleration(event)) {
        // Calculate sleep duration and reset tracking
        final sleepDuration = DateTime.now().difference(_sleepStartTime!);
        _logger.w('Sleep ended. Duration: $sleepDuration');
        _logger.d('Sleep duration: $sleepDuration');
        _isSleeping = false;
        _sleepStartTime = null;
        _recentAccelerometerEvents.clear();
        _recentGyroscopeEvents.clear();
      }
    }
  }

  void _handleGyroscopeEvent(GyroscopeEvent event) {
    _recentGyroscopeEvents.add(TimedGyroscopeEvent(event));
    _recentGyroscopeEvents.removeWhere((e) => e.timestamp.isBefore(
        DateTime.now()
            .subtract(Duration(seconds: kInactivityDurationSeconds))));

    if (_isSleeping) {
      // Check for wake-up event
      if (_isSignificantRotation(event)) {
        // Calculate sleep duration and reset tracking
        final sleepDuration = DateTime.now().difference(_sleepStartTime!);
        print('Sleep duration: $sleepDuration');
        _isSleeping = false;
        _sleepStartTime = null;
        _recentAccelerometerEvents.clear();
        _recentGyroscopeEvents.clear();
      }
    }
  }

  // bool _isInactive(List<TimedAccelerometerEvent> events) {
  //   return events.isNotEmpty &&
  //       events.every((timedEvent) =>
  //           timedEvent.event.x.abs() < kInactivityThreshold &&
  //           timedEvent.event.y.abs() < kInactivityThreshold &&
  //           timedEvent.event.z.abs() < kInactivityThreshold);
  // }
  bool _isInactive(List<TimedAccelerometerEvent> events) {
    // Determine the sensor frequency (number of events per second)
    int sensorFrequency =
        100; // Adjust this value based on your sensor's actual frequency

    // Calculate the number of events to consider for inactivity
    int numEvents = kInactivityDurationSeconds * sensorFrequency;

    // Check if the device has been inactive for the specified duration
    return events.length >= numEvents &&
        events.sublist(events.length - numEvents).every((timedEvent) =>
            timedEvent.event.x.abs() < kInactivityThreshold &&
            timedEvent.event.y.abs() < kInactivityThreshold &&
            timedEvent.event.z.abs() < kInactivityThreshold);
  }

  bool _isSignificantAcceleration(AccelerometerEvent event) {
    // Determine if the acceleration exceeds the significant movement threshold
    return event.x.abs() > kSignificantMovementThreshold ||
        event.y.abs() > kSignificantMovementThreshold ||
        event.z.abs() > kSignificantMovementThreshold;
  }

  bool _isSignificantRotation(GyroscopeEvent event) {
    // Determine if the rotation rate exceeds the significant movement threshold
    return event.x.abs() > kSignificantMovementThreshold ||
        event.y.abs() > kSignificantMovementThreshold ||
        event.z.abs() > kSignificantMovementThreshold;
  }

  void dispose() {
    // Cancel stream subscriptions
    _accelerometerSubscription.cancel();
    _gyroscopeSubscription.cancel();
  }
}
