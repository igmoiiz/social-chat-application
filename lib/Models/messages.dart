import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  //  variables
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timeStamp;

  //  constructor
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timeStamp,
  });

  //  convert all the information and variables to a Map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'messages': message,
      'timeStamp': timeStamp,
    };
  }
}
