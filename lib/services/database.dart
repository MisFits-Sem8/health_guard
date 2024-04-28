import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future addUserName(String name) async {
    return await userCollection.doc(uid).set({"name": name});
  }

  Future addUserdata(int height, int weight, int age, double water,
      double workout, double sleep, String gender) async {
    print(uid.length);
    return await userCollection.doc(uid).update({
      "age": age,
      "weight": weight,
      "height": height,
      "water": water,
      "workout": workout,
      "sleep": sleep,
      "gender": gender
    });
  }

  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(uid).snapshots().map((DocumentSnapshot doc) {
      return doc;
    });
  }
}
