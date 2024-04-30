import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/view/message/message.dart';
import 'package:intl/intl.dart';

import '../../services/auth_service.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final _auth = AuthService();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: TColour.white,
          centerTitle: true,
          elevation: 0,
          // leadingWidth: 0,
          title: Text(
            "HealthGuard",
            style: TextStyle(
                color: TColour.black1,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
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
                height: media.height * 0.05,
                child: Center(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) {
                      return LinearGradient(
                              colors: TColour.primary,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)
                          .createShader(
                              Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                    },
                    child: Text(
                      DateFormat.yMMMd().format(message.date),
                      style: TextStyle(
                          color: TColour.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
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
                      ? TColour.primaryColor2
                      : TColour.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(message.text,
                        style: TextStyle(
                            color: TColour.black1.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
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
                    if (_messageController.text.isNotEmpty) {
                      Message newMessage = Message(text: _messageController.text, date: DateTime.now(), isSentByMe: true);
                      _auth.sendText(newMessage);
                      messages.add(newMessage);
                      _messageController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Icon(
                    Icons.send_rounded,
                    color: TColour.white,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
