import "package:cloud_firestore/cloud_firestore.dart";

import "../view/message/message.dart";

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');

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

  Future<void> addMessageToChat(Message message) async {
    try {
      Timestamp timestamp = Timestamp.fromDate(message.date);
      await chatCollection
          .doc(uid)
          .collection("messages")
          .doc(timestamp.toDate().toString())
          .set({
        'text': message.text,
        'sentTime': message.date,
        'isSentByMe': message.isSentByMe,
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // List<Message> getMessages() {
  //   try{
  //     chatCollection.
  //   }
  // }
}
