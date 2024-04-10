import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final Timestamp birthday;
  final bool isPremium;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.birthday,
    required this.isPremium,
  });
  toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "birthday": birthday,
      "isPremium": isPremium,
    };
  }

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          email: json['email']! as String,
          password: json['password']! as String,
          isPremium: json['isPremium']! as bool,
          birthday: json['birthday']! as Timestamp,
        );
  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    bool? isPremium,
    Timestamp? updatedOn,
    Timestamp? birthday,
  }) {
    return UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        birthday: birthday ?? this.birthday,
        isPremium: isPremium ?? this.isPremium);
  }
}
