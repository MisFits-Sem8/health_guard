class Sleep {
  late int id;
  late int userId;
  late String date;
  late int duration;

  Sleep(this.userId, this.date, this.duration);

  Sleep.withId(this.id, this.userId, this.date, this.duration);

  // Convert a Sleep object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['user_id'] = userId;
    map['date'] = date;
    map['duration'] = duration;

    return map;
  }

  // Extract a Sleep object from a Map object
  factory Sleep.fromMapObject(Map<String, dynamic> map) {
    return Sleep.withId(
      map['id'],
      map['user_id'],
      map['date'],
      map['duration'],
    );
  }

  // Update duration for a given sleep record
  void updateDuration(int duration) {
    this.duration = duration;
  }
}
