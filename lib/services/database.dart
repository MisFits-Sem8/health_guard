import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future addUserName(String name) async {
    return await userCollection.doc(uid).set({"name": name});
  }

  Future addUserdata(int height, int weight, int age, double water, double workout, double sleep, String gender) async {
    return await userCollection.doc(uid).set({"age": age, "weight": weight, "height": height, "water": water, "workout":workout, "sleep":sleep, "gender":gender});
  }
}
