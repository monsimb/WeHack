import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  String _response = "";
  bool _isLoading = false;

  final String _cloudflareWorkerUrl =
      "https://rag-ai.moniquesimberg.workers.dev/";

  // Generate a unique user ID for the session (replace with dynamic logic if needed)
  final String _userId = DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _sendQuestion(String question) async {
    if (question.isEmpty) {
      setState(() {
        _response = "Please enter a question.";
      });
      return;
    }

    final Uri uri = Uri.parse(
        "$_cloudflareWorkerUrl?userId=$_userId&text=${Uri.encodeComponent(question)}");

    setState(() {
      _isLoading = true; // Show loading message
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Parse the response if it's JSON
        final responseBody = response.body;
        setState(() {
          _response = responseBody; // Update with the server's response
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with Penny!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 55, 121, 140),
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
                padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _isLoading ? "\nPenny is Thinking...\n" : _response,    // loading message or response
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            ),
            SizedBox(height: 16),
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
                      _controller
                          .clear(); // Clear the input field after sending
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
