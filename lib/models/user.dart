class UserModel {
  final String? uid;
  String? email;

  UserModel({this.uid, required this.email});
}

class UserDataModel {
  late int id;
  late String name;
  late String gender;
  late int age;
  late int height;
  late int weight;
  late double water;
  late double sleep;
  late double workout;

  UserDataModel(this.id, this.name, this.age, this.height, this.weight,
      this.sleep, this.workout, this.water, this.gender);

  // UserDataModel(this.name, this.age, this.height, this.weight, this.sleep,
  //     this.workout, this.water, this.gender);

  static UserDataModel fromMapObject(Map<String, dynamic> userMapList) {
    return UserDataModel(
      userMapList['id'],
      userMapList['name'],
      userMapList['age'],
      userMapList['height'],
      userMapList['weight'],
      userMapList['sleep'].toDouble(),
      userMapList['workout'].toDouble(),
      userMapList['water'].toDouble(),
      userMapList['gender'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['age'] = age;
    map['height'] = height;
    map['weight'] = weight;
    map['sleep'] = sleep;
    map['workout'] = workout;
    map['water'] = water;
    map['gender'] = gender;

    return map;
  }
}
