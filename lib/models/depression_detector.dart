// DepressionDetector class
class DepressionDetector {
  late int id;
  late int userId;
  late String time;
  late int stressLevel;
  late String sleepingStatus;
  late int sadness;
  late int joy;
  late int love;
  late int angry;
  late int fear;
  late int surprise;
  late String thoughts;

  DepressionDetector(
    this.id,
    this.userId,
    this.time,
    this.stressLevel,
    this.sleepingStatus,
    this.sadness,
    this.joy,
    this.love,
    this.angry,
    this.fear,
    this.surprise,
    this.thoughts,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['user_id'] = userId;
    map['time'] = time;
    map['stress_level'] = stressLevel;
    map['sleeping_status'] = sleepingStatus;
    map['sadness'] = sadness;
    map['joy'] = joy;
    map['love'] = love;
    map['angry'] = angry;
    map['fear'] = fear;
    map['surprise'] = surprise;
    map['thoughts'] = thoughts;

    return map;
  }

  factory DepressionDetector.fromMapObject(Map<String, dynamic> map) {
    return DepressionDetector(
      map['id'],
      map['user_id'],
      map['time'],
      map['stress_level'],
      map['sleeping_status'],
      map['sadness'],
      map['joy'],
      map['love'],
      map['angry'],
      map['fear'],
      map['surprise'],
      map['thoughts'],
    );
  }

  void updateEmotions(
    int sadness,
    int joy,
    int love,
    int angry,
    int fear,
    int surprise,
  ) {
    this.sadness = sadness;
    this.joy = joy;
    this.love = love;
    this.angry = angry;
    this.fear = fear;
    this.surprise = surprise;
  }
}
