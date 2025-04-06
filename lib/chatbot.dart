import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
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
      appBar: AppBar(
        title: const Text(
          'Chat with Penny!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff37798c), // Match the dashboard theme
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 121, 140),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _response,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Ask a question!',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        _sendQuestion(_controller.text);
                      },
                      child: const Text('Send'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Chatbot extends StatelessWidget {
  const Chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with Penny!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff37798c), // Match the dashboard theme
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Chat with Penny!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
