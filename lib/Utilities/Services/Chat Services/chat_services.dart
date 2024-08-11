import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication/Models/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  //   get instance of fire store
  final FirebaseFirestore fireStoreRef = FirebaseFirestore.instance;

  //  get instance for firebase authentication
  final auth = FirebaseAuth.instance;

  //  get user stream
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
}
