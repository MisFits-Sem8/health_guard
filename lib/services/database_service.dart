import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/data/models/user_model.dart';

const String USERS_COLLECTION_REF = "users";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _usersRef;
  DatabaseService() {
    _usersRef =
        _firestore.collection(USERS_COLLECTION_REF).withConverter<UserModel>(
            fromFirestore: (snapshots, _) => UserModel.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (UserModel, _) => UserModel.toJson());
  }
  Stream<QuerySnapshot> getUsers() {
    return _usersRef.snapshots();
  }

  void addUser(UserModel user) async {
    _usersRef.add(user);

  }

  void updateUser(String id,UserModel user){
    _usersRef.doc(id).update(user.toJson());
  }
  void deleteUser(String id){
    _usersRef.doc(id).delete();
  }
}
