// Target class
class Target {
  // late int id;
  late String date;
  late String userId;
  late int calories;
  late int water;
  late int steps;

  Target(this.date, this.userId, this.calories, this.water, this.steps);

  // Target.withId(this.id, this.userId, this.calories, this.water, this.steps);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['date'] = date;
    map['user_id'] = userId;
    map['calories'] = calories;
    map['water'] = water;
    map['steps'] = steps;

    return map;
  }

  factory Target.fromMapObject(Map<String, dynamic> map) {
    return Target(
      map['date'],
      map['user_id'],
      map['calories'],
      map['water'],
      map['steps'],
    );
  }

  void updateTarget(int calories, int water, int steps) {
    this.calories = calories;
    this.water = water;
    this.steps = steps;
  }
}
