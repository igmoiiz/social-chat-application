// ignore_for_file: must_be_immutable

import 'package:communication/Utilities/Services/Chat%20Services/chat_services.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  String message;
  bool isCurrentUser;
  String messageId;
  String userId;
  ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
  });

  //  show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            spacing: 5,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              //  report message button
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  reportContent(context, messageId, userId);
                },
                leading: Icon(
                  Icons.flag,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Report',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              //  block user button
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  blockUser(context, userId);
                },
                leading: Icon(
                  Icons.block_sharp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Block',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              //  cancel button
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.cancel_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //  report message
  void reportContent(BuildContext context, String messageId, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Report Message',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to report this message?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        actions: [
          //  cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          //  report button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ChatServices().reportUser(userId, messageId);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Message Reported Successfully!')));
            },
            child: Text(
              'Report',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  block user
  void blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Block Message',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to Block this user?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        actions: [
          //  cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          //  block button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ChatServices().blockUser(userId);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User Blocked Successfully!')));
            },
            child: Text(
              'Block',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          //  show options
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isCurrentUser
              ? Colors.green.shade700
              : Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isCurrentUser
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
