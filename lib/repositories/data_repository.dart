import 'package:health_app/models/daily_steps.dart';

class DataRepository {
  static final DataRepository _instance = DataRepository._internal();

  factory DataRepository() => _instance;

  DataRepository._internal();

  Map<int, DailySteps> _recordSteps = {};

  Map<int, DailySteps> get recordSteps => _recordSteps;

  void addStep(int key, DailySteps step) {
    _recordSteps[key] = step;
  }

  void updateStep(int key, DailySteps step) {
    if (_recordSteps.containsKey(key)) {
      DailySteps? record = _recordSteps[key];
      if (record != null && record.date == step.date) {
        _recordSteps[key]!.steps += step.steps;
      } else {
        // If the record exists but dates do not match, add the new step to the map with a new key
        int maxKey =
            _recordSteps.keys.reduce((curr, next) => curr > next ? curr : next);
        _recordSteps[maxKey + 1] = step;
      }
    } else {
      // If the record doesn't exist, add it to the map
      _recordSteps[key] = step;
    }
    reorganizeMap();
  }

  void reorganizeMap() {
    // Sort the map by date
    var sortedEntries = _recordSteps.entries.toList()
      ..sort((a, b) => a.value.date.compareTo(b.value.date));

    // Reassign keys starting from 0
    _recordSteps = {};
    int j = 0;
    for (int i = 0; i < sortedEntries.length; i++) {
      // If the dates are equal, add the steps together
      // debugPrint("sortedEntries[i].value.date");
      // debugPrint(sortedEntries[i].value.date);
      if (i != 0 &&
          sortedEntries[i].value.date == sortedEntries[i - 1].value.date) {
        _recordSteps[j - 1]!.steps += sortedEntries[i].value.steps;
      } else {
        _recordSteps[j] = sortedEntries[i].value;
        j++;
      }
    }
  }

  void deleteStep(int key) {
    _recordSteps.remove(key);
  }

  DailySteps? getRecord(int key) {
    DailySteps? record = _recordSteps[key];
    // if (record == null) {
    //   return DailySteps(key, 0);
    // }
    return record;
  }

  @override
  String toString() {
    return _recordSteps.entries
        .map((e) => '${e.key}: ${e.value.steps}')
        .join(',\n ');
  }
}
