class DailySteps {
  // int? id;
  late String date;
  late int steps;
  late String userId;

  DailySteps(this.date, this.steps, this.userId);

  // DailySteps.withId(this.id, this.date, this.steps, this.userId);

  // Convert a DailySteps object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    // if (id != null) {
    //   map['id'] = id;
    // }

    map['date'] = date;
    map['steps'] = steps;
    map['user_id'] = userId;

    return map;
  }

  // Extract a DailySteps object from a Map object
  factory DailySteps.fromMapObject(Map<String, dynamic> map) {
    return DailySteps(
      // map['id'],
      map['date'],
      map['steps'],
      map['user_id'],
    );
  }

  // Update steps count for a given date
  void updateSteps(int steps) {
    this.steps = steps;
  }
}
