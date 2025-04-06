// chat.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  String _response = "";

  final String _cloudflareWorkerUrl =
      "https://rag-ai.moniquesimberg.workers.dev/";

  Future<void> _sendQuestion(String question) async {
    final Uri uri = Uri.parse("$_cloudflareWorkerUrl?text=$question");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        setState(() {
          _response = response.body;
        });
      } else {
        setState(() {
          _response = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "Failed to get response: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat with AI")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Ask a question"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _sendQuestion(_controller.text);
              },
              child: Text("Send"),
            ),
            SizedBox(height: 16),
            Text("Response: $_response"),
          ],
        ),
      ),
    );
  }
}
