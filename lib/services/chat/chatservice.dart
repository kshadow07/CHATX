import 'package:chtx/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // instance of firestore and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            // go through each indiviual user
            final user = doc.data();
            return user;
          },
        ).toList();
      },
    );
  }

// send message
  Future<void> sendMessage(String recevierID, message) async {
    final String CurrentUserId = _auth.currentUser!.uid;
    final String? CurrentUseremail = _auth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
        senderID: CurrentUserId,
        senderEmail: CurrentUseremail,
        recevierId: recevierID,
        message: message,
        timestamp: timestamp);

    // ImageUrl imagesUrl = ImageUrl(imageUrl);

    //chat room id for unique rooms
    List<String> ids = [CurrentUserId, recevierID];
    ids.sort();
    String Chatroomid = ids.join("_");

    // add new message to the database
    await _firestore
        .collection('chat_room')
        .doc(Chatroomid)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String senderid, recevierid) {
    // construct a chat room id for the users
    List<String> ids = [senderid, recevierid];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
