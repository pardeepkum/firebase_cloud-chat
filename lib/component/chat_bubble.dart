import 'package:flutter/material.dart';

class ChatBubbleScreen extends StatelessWidget {
  final String message;
  const ChatBubbleScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: Colors.blue),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
