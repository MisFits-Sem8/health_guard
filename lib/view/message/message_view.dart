import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/view/message/message.dart';
import 'package:intl/intl.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: TColour.white,
        body: Column(children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (Message message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: media.height * 0.07,
                child: Center(
                  child: Card(
                    color: TColour.primaryColor2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: TextStyle(color: TColour.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: message.isSentByMe
                      ? TColour.secondaryColor1
                      : TColour.white,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(message.text),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: TColour.lightGray,
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Type your message here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onSubmitted: (text) {
                        final message = Message(
                            text: text, date: DateTime.now(), isSentByMe: true);
                        setState(() {
                          if (text != "") {
                            messages.add(message);
                          }
                        });
                        _messageController.clear();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: media.width * 0.02,
                ),
                FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: TColour.primaryColor1,
                  onPressed: () {
                    final text = _messageController.text;
                    final message = Message(
                        text: text, date: DateTime.now(), isSentByMe: true);
                    setState(() {
                      if (text != "") {
                        messages.add(message);
                      }
                    });
                    _messageController.clear();
                  },
                  child: Icon(Icons.send_rounded, color: TColour.white,),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
