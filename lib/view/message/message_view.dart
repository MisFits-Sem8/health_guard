import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/view/message/message.dart';
import 'package:intl/intl.dart';

import '../../services/auth_service.dart';

class MessageView extends StatefulWidget {
  List<Message> messages;

  MessageView({Key? key, required this.messages}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final _auth = AuthService();
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessages(String text, List<Message> messages) async {
    List<Message> loadedMessages = await _auth.sendText(text, messages);
    setState(() {
      widget.messages = loadedMessages;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.extentTotal);
    });
  }

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
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: widget.messages,
              groupBy: (Message message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => Container(
                color: TColour.white.withOpacity(0.8),
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
                        // final message = Message(
                        //     text: text, date: DateTime.now(), isSentByMe: true);
                        setState(() {
                          if (text != "") {
                            _sendMessages(text, widget.messages);
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
                    setState(() {
                      if (text != "") {
                        _sendMessages(text, widget.messages);
                      }
                    });
                    _messageController.clear();
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
