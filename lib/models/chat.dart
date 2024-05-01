// Chat class
class Chat {
  // late int id;
  late String userId;
  late bool isSender;
  late String message;

  Chat(this.userId, this.isSender, this.message);

  // Chat.withId(this.id, this.userId, this.isSender, this.message);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    // map['id'] = id;
    map['user_id'] = userId;
    map['is_sender'] = isSender ? 1 : 0;
    map['message'] = message;

    return map;
  }

  factory Chat.fromMapObject(Map<String, dynamic> map) {
    return Chat(
      // map['id'],
      map['user_id'],
      map['is_sender'] == 1,
      map['message'],
    );
  }

  void updateMessage(String message) {
    this.message = message;
  }
}
