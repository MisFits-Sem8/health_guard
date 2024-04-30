// Schedule class
class Schedule {
  late int id;
  late int userId;
  late String type;
  late String time;
  late bool isActive;

  Schedule(this.userId, this.type, this.time, this.isActive);

  Schedule.withId(this.id, this.userId, this.type, this.time, this.isActive);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['user_id'] = userId;
    map['type'] = type;
    map['time'] = time;
    map['is_active'] = isActive ? 1 : 0;

    return map;
  }

  factory Schedule.fromMapObject(Map<String, dynamic> map) {
    return Schedule.withId(
      map['id'],
      map['user_id'],
      map['type'],
      map['time'],
      map['is_active'] == 1,
    );
  }

  void updateIsActive(bool isActive) {
    this.isActive = isActive;
  }
}
