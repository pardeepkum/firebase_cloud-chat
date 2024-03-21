import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  /// get instance of auth and fireStores
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///Send Message
  Future<void> sendMessage(String receiverId, String message) async {
   /// get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    ///create a new message
    Message newMessage = Message(
        senderEmail: currentUserId,
        senderId: currentUserEmail,
        receiverId: receiverId,
      timestamp: timestamp,
       message: message,
    );

    ///construct chat room id from current user id and receiver Id (sorted to ensure uniqueness)

    List<String> ids = [currentUserId, receiverId];
    ids.sort();

    /// sort the ids(this ensure chatroom ids is always the same for any pair of people)
    String chatRoomId = ids.join("_");

    ///combilne the ids into a single String to use a chatRoomId

    ///add new message to database

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  ///Get Message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    ///construct chat room id from user ids (sorted to ensure it matches the id used when sending message)

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
