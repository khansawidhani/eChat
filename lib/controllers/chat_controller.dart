import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echat/constants/constants.dart';
import 'package:echat/models/message_model.dart';
import 'package:echat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final CollectionReference _messagesCollectionRef =
      FirebaseFirestore.instance.collection('messages');
  StreamController<List<MessageModel>> chatStream =
      StreamController<List<MessageModel>>.broadcast();
  UserModel friend = Get.arguments;
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    listenToMessages(friend.id);
  }

  RxBool isEmojiPicker = false.obs;
  List<MessageModel>? messages;
  // RxList<MessageModel>? get messages => _messages;
  RxBool isLoading = false.obs;

  void showLoading() {
    isLoading.toggle();
  }

  void hideLoading() {
    isLoading.toggle();
  }
  
  void showEmojiPicker() {
    isEmojiPicker.toggle();
  }

  Stream getRealtimeMessages(String friendId, String currentUserId) {
    requestMessage(friendId, currentUserId);
    return chatStream.stream;
  }

  void requestMessage(String friendId, String currentUserId) {
    var messageQuerySnapshot = _messagesCollectionRef
        .orderBy('createdAt', descending: true)
        .snapshots();
    messageQuerySnapshot.listen((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
      var msgs = snapshot.docs
          .map((DocumentSnapshot document) =>
              MessageModel.fromMap(document.data()! as Map<String, dynamic>))
          .where((msg) =>
              (msg.recieverId == friend.id && msg.senderId == currentUserId) ||
              (msg.recieverId == currentUserId && msg.senderId == friend.id))
              .toList();
              chatStream.add(msgs);
      }
    });

    // 
    
  }

  void listenToMessages(String friendId){ 
    showLoading();
    getRealtimeMessages(friendId, currentUserId)
    .listen((messageData) {
      List<MessageModel> updatedMessages = messageData;
      hideLoading();
      if(updatedMessages.isNotEmpty){
        messages = updatedMessages; 
        update();
      } 
     });
  }

  Future createMessage(TextEditingController messageBody, String recieverId,
      String recieverName) async {
    final MessageModel message = MessageModel(
      recieverId: recieverId,
      recieverName: recieverName,
      message: messageBody.text,
      senderId: currentUserId,
      senderName: Constants.prefs!.getString('name').toString(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await _messagesCollectionRef.doc().set(message.toJson());
      messageBody.clear();
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

}
