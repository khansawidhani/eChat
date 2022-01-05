import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:echat/controllers/chat_controller.dart';
import 'package:echat/models/user_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:echat/models/message_model.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);
  final chatController = Get.find<ChatController>();
  final UserModel friend = Get.arguments;
  final FocusNode _messageFocus = FocusNode();
  final TextEditingController _messageBodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
        title: Text(
          friend.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Stack(
        children: [
          // background
          Container(
            color: Colors.deepPurple.shade300,
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height - 100,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: GetBuilder<ChatController>(
                      builder: (controller) => controller.messages != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListView.builder(
                                  reverse: true,
                                  itemCount: controller.messages!.length,
                                  itemBuilder: (context, index) {
                                    MessageModel currentMessage = chatController.messages![index];
                                    String message = currentMessage.message;
                                    bool sent = currentMessage.senderId != friend.id;
                                    bool isSender = currentMessage.senderId == chatController.currentUserId; 
                                    return buildMessageBubble(message, isSender, sent);
                                  }),
                            )
                          : emptyInbox(),
                    )),
              )

              // write message field
              ,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 5,
                      left: 3,
                      right: 3,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _messageFocus.unfocus();
                              chatController.showEmojiPicker();
                            },
                            icon: const Icon(Icons.tag_faces_outlined)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file_outlined)),
                        Expanded(
                          child: TextField(
                            focusNode: _messageFocus,
                            onTap: () {
                              if (chatController.isEmojiPicker.isTrue) {
                                chatController.showEmojiPicker();
                              }
                            },
                            controller: _messageBodyController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Send Message',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await chatController.createMessage(
                                _messageBodyController,
                                friend.id,
                                friend.name);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.green.shade600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                    return Offstage(
                      offstage: chatController.isEmojiPicker.isFalse,
                      child: SizedBox(
                        height: 250,
                        child: EmojiPicker(
                            config: const Config(
                              columns: 7,
                              initCategory: Category.RECENT,
                            ),
                            onBackspacePressed: () {
                              _messageBodyController
                                ..text = _messageBodyController
                                    .text.characters
                                    .skipLast(1)
                                    .toString()
                                ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: _messageBodyController
                                            .text.length));
                            },
                            onEmojiSelected: (category, emoji) {
                              _messageBodyController
                                ..text += emoji.emoji
                                ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: _messageBodyController
                                            .text.length));
                            }),
                      ),
                    );
                  })
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildMessageBubble(String message, bool isSender, bool sent) {
    return BubbleNormal(
      text: message,
      isSender: isSender,
      color: const Color(0xFFE6E6EB),
      tail: true,
      sent: sent,
    );
  }

  Widget emptyInbox() {
    return Center(
      child: Image.asset(
        'assets/images/empty_inbox.jpg',
        height: 250,
      ),
    );
  }
}
