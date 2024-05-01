class DailySteps {
  int? id;
  late String date;
  late int steps;

  DailySteps(this.date, this.steps);

  DailySteps.withId(this.id, this.date, this.steps);

  // Convert a DailySteps object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['date'] = date;
    map['steps'] = steps;

    return map;
  }

  // Extract a DailySteps object from a Map object
  DailySteps.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.date = map['date'];
    this.steps = map['steps'];
  }

  // Update steps count for a given date
  void updateSteps(int steps) {
    this.steps = steps;
  }
}
