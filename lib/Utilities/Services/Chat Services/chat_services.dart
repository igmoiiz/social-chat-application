import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication/Models/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier {
  //   get instance of fire store
  final FirebaseFirestore fireStoreRef = FirebaseFirestore.instance;

  //  get instance for firebase authentication
  final auth = FirebaseAuth.instance;

  //  get all user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return fireStoreRef.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //  go through each individual user
        final user = doc.data();
        //  return user
        return user;
      }).toList();
    });
  }

  //  get all users except the blocked users stream
  Stream<List<Map<String, dynamic>>> getUsersStreamExceptBlocked() {
    final currentUser = auth.currentUser;
    return fireStoreRef
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('Blocked')
        .snapshots()
        .asyncMap((snapshot) async {
      //  get blocked user ids
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();
      //  get all users ids
      final userSnapshot = await fireStoreRef.collection('Users').get();
      //  return as stream list
      return userSnapshot.docs
          .where((doc) =>
              doc.data()['email'] != currentUser.email &&
              !blockedUserIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  //  send message
  Future<void> sendMessages(String receiverId, String message) async {
    //  get current user information
    final String userId = auth.currentUser!.uid;
    final String userEmail = auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();
    //  create a new message
    Message newMessage = Message(
        senderId: userId,
        senderEmail: userEmail,
        receiverId: receiverId,
        message: message,
        timeStamp: timeStamp);
    //  construct a new room id for two users (sorted to ensure uniqueness)
    List<String> ids = [userId, receiverId];
    ids.sort(); // sort the ids (ensuring that the chat room id is same for any two people)
    String chatRoomId = ids.join('_');
    //  add new messages to database
    await fireStoreRef
        .collection('Chat_Rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //  get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //  construct a chat room id for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return fireStoreRef
        .collection('Chat_Rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  //  report the user
  Future<void> reportUser(String userId, String messageId) async {
    final currentUser = auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'reportedAt': Timestamp.now(),
      'messageOwnerId': userId,
    };
    await fireStoreRef.collection('Reports').add(report);
  }

  //  block the user
  Future<void> blockUser(String userId) async {
    final currentUser = auth.currentUser;
    await fireStoreRef
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('Blocked')
        .doc(userId)
        .set({});
    notifyListeners();
  }

  //  unblock the user
  Future<void> unBlockUser(String blockedUserId) async {
    final currentUser = auth.currentUser;
    await fireStoreRef
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('Blocked')
        .doc(blockedUserId)
        .delete();
    notifyListeners();
  }

  //  get blocked users
  Stream<List<Map<String, dynamic>>> getBlockedUserStream(String userId) {
    return fireStoreRef
        .collection('Users')
        .doc(userId)
        .collection('Blocked')
        .snapshots()
        .asyncMap(
      (snapshot) async {
        //  get the list of blocked user ids
        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();
        final userDocs = await Future.wait(
          blockedUserIds.map(
            (id) => fireStoreRef.collection('Users').doc(id).get(),
          ),
        );
        //  return the list of blocked users as a list
        return userDocs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      },
    );
  }
}
