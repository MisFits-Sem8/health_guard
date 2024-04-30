// Target class
class Target {
  late int id;
  late int userId;
  late int calories;
  late int water;
  late int steps;

  Target(this.userId, this.calories, this.water, this.steps);

  Target.withId(this.id, this.userId, this.calories, this.water, this.steps);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['user_id'] = userId;
    map['calories'] = calories;
    map['water'] = water;
    map['steps'] = steps;

    return map;
  }

  factory Target.fromMapObject(Map<String, dynamic> map) {
    return Target.withId(
      map['id'],
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
