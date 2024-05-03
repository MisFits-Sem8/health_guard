class WaterIntake {
  late String date;
  late int water;
  late String userId;

  WaterIntake(this.date, this.water, this.userId);

  // Convert a WaterIntake object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['date'] = date;
    map['water'] = water;
    map['user_id'] = userId;

    return map;
  }

  // Extract a WaterIntake object from a Map object
  factory WaterIntake.fromMapObject(Map<String, dynamic> map) {
    return WaterIntake(
      map['date'],
      map['water'],
      map['user_id'],
    );
  }

  // Update water intake for a given date
  void updateWater(int water) {
    this.water = water;
  }
}
