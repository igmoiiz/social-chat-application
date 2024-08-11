// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication/Components/chat_bubble.dart';
import 'package:communication/Utilities/Services/Authentication%20Services/auth_services.dart';
import 'package:communication/Utilities/Services/Chat%20Services/chat_services.dart';
import 'package:communication/Utilities/controllers.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final receiverEmail;
  final receiverId;
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });

  //  getting chat services
  final chatServices = ChatServices();
  //  getting authentication services
  final authServices = AuthServices();
  //  instance for getting input controllers
  final inputControllers = InputControllers();
  //  method for sending messages
  void sendMessages() async {
    //  if there is something inside text field to send a message (ensures no blank messages are being sent)
    if (inputControllers.textController.text.isNotEmpty) {
      //  send the message
      await chatServices.sendMessages(
        receiverId,
        inputControllers.textController.text,
      );
      //  clear the controller after sending the text messages
      inputControllers.textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //  display all the messages
          Expanded(child: _buildMessagesList()),
          //  user input section
          _userInput(context),
        ],
      ),
    );
  }

  //  building messages list
  Widget _buildMessagesList() {
    String senderId = authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatServices.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        //  errors
        if (snapshot.hasError) {
          return Align(
              alignment: Alignment.center,
              child: Text('Exception has occurred: ${snapshot.error}'));
        }
        //  loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Text('Loading Please Wait...'),
              ],
            ),
          );
        }
        //  list view

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItems(doc))
              .toList(),
        );
      },
    );
  }

  //  build message items
  Widget _buildMessageItems(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //  checking if it is the current user
    bool isCurrentUser = data['senderId'] == authServices.getCurrentUser()!.uid;
    //  align messages to right if it is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child:
          ChatBubble(message: data['messages'], isCurrentUser: isCurrentUser),
    );
  }

  //  build user input
  Widget _userInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  text field should take up most of the space
          Expanded(
            child: TextFormField(
              controller: inputControllers.textController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.grey), // Default border color
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .primary), // Border color when focused
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Send Message..',
              ),
            ),
          ),
          //  gap between icon button and text field
          SizedBox(width: MediaQuery.of(context).size.width * .02),
          //  send button
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.green.shade700,
            ),
            child: IconButton(
              onPressed: () {
                sendMessages();
              },
              icon: Icon(Icons.arrow_upward_sharp,
                  color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ],
      ),
    );
  }
}
