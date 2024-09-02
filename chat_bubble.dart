import 'dart:ui';

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? Colors.white.withOpacity(0.3)
              : Colors.blue.shade500.withOpacity(0.3),
          borderRadius: isCurrentUser
              ? const BorderRadius.only(
                  topRight: Radius.circular(2),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))
              : const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
        ),
        child: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 17),
        ));
  }
}
