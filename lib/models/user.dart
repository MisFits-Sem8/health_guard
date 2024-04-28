class UserModel {
  final String? uid;
  String? email;

  UserModel({this.uid, required this.email});
}

class UserDataModel {
  final String name;
  final String gender;
  final int age;
  final int height;
  final int weight;
  final double water;
  final double sleep;
  final double workout;

  UserDataModel(this.name, this.age, this.height, this.weight,
      this.sleep, this.workout, this.water, this.gender);
}
