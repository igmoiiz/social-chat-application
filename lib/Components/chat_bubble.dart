// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  String message;
  bool isCurrentUser;
  ChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
    );
  }
}
