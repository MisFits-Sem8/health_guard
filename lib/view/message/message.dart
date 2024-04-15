class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  Message({required this.text, required this.date, required this.isSentByMe});
}

List<Message> messages = [
  Message(
      text: "Hola HealthGuard!",
      date: DateTime.now().subtract(const Duration(days: 2)),
      isSentByMe: true),
  Message(
      text: "Hello! How can I assist you today?",
      date: DateTime.now().subtract(const Duration(days: 1, hours: 20)),
      isSentByMe: false),
  Message(
      text: "I'm looking for a diet plan. Can you help?",
      date: DateTime.now().subtract(const Duration(days: 1, hours: 15)),
      isSentByMe: true),
  Message(
      text:
          "Of course! Could you please provide me with some details like your age, weight, height, and any dietary restrictions you have?",
      date: DateTime.now().subtract(const Duration(days: 1, hours: 10)),
      isSentByMe: false),
  Message(
      text:
          "Sure, I am 30 years old, weigh 70 kg, my height is 175 cm, and I'm vegetarian.",
      date: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      isSentByMe: true),
  Message(
      text:
          "Great! Based on your details, I will create a personalized vegetarian diet plan for you. Please wait a moment...",
      date: DateTime.now().subtract(const Duration(hours: 8)),
      isSentByMe: false),
  Message(
      text: "Here is your personalized diet plan...",
      date: DateTime.now(),
      isSentByMe: false),
];
