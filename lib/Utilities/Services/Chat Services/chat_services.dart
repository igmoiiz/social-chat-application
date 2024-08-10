import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  //   get instance of fire store
  final FirebaseFirestore fireStoreRef = FirebaseFirestore.instance;

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

  //  get message
}
