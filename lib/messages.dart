import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({
    Key? key,
    required this.message,
    this.errorMessage,
  }) : super(key: key);
  final String message;
  final String? errorMessage;

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Center(
          child: Text(
            'Message',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                widget.message,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.errorMessage ?? '',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
