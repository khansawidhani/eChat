import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String recieverId;
  String senderId;
  String recieverName;
  String senderName;
  String message;
  int createdAt;
  
  MessageModel({
    required this.recieverId,
    required this.senderId,
    required this.senderName,
    required this.recieverName,
    required this.message,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final recieverId = json['recieverId'] as String;
    final senderId = json['senderId'] as String;
    final recieverName = json['recieverName'] as String;
    final senderName = json['senderName'] as String;
    final message = json['message'] as String;
    final createdAt = json['createdAt'] as int;
    return MessageModel(
        recieverId: recieverId,
        senderId: senderId,
        senderName: senderName,
        recieverName: recieverName,
        message: message,
        createdAt: createdAt);
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
        recieverId: map["recieverId"],
        senderId: map['senderId'],
        senderName: map['senderName'],
        recieverName: map["recieverName"],
        message: map['message'],
        createdAt: map['createdAt']);
  }
  Map<String, dynamic> toJson() {
    return {
      'receieverId' : recieverId, 
      'senderId' : senderId, 
      'recieverName' : recieverName, 
      'senderName' : senderName, 
      'message' : message, 
      'createdAt' : createdAt
    };
  }
}
