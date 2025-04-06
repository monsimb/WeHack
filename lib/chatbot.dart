import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = []; // List to store messages
  bool _isLoading = false;
  Timer? _thinkingTimer;
  String _thinkingMessage = "Penny is Thinking";

  final String _cloudflareWorkerUrl =
      "https://rag-ai.moniquesimberg.workers.dev/";

  final String _userId = DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _sendQuestion(String question) async {
    if (question.isEmpty) {
      return;
    }

    // Add the user's question to the messages list
    setState(() {
      _messages.add({"role": "user", "content": question});
      _isLoading = true;

      // Add a temporary "Penny is Thinking..." message
      _messages.add({"role": "assistant", "content": _thinkingMessage});
    });

    // Start the animation for "Penny is Thinking..."
    _startThinkingAnimation();

    final Uri uri = Uri.parse(
        "$_cloudflareWorkerUrl?userId=$_userId&text=${Uri.encodeComponent(question)}");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        setState(() {
          // Replace the "Penny is Thinking..." message with the actual response
          _messages.removeLast();
          _messages.add({"role": "assistant", "content": responseBody});
        });
      } else {
        setState(() {
          // Replace the "Penny is Thinking..." message with an error message
          _messages.removeLast();
          _messages.add({
            "role": "assistant",
            "content": "Error: ${response.statusCode}"
          });
        });
      }
    } catch (e) {
      setState(() {
        // Replace the "Penny is Thinking..." message with a failure message
        _messages.removeLast();
        _messages.add(
            {"role": "assistant", "content": "Failed to get response: $e"});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _stopThinkingAnimation();
    }
  }

  void _startThinkingAnimation() {
    _thinkingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (_thinkingMessage.endsWith("...")) {
          _thinkingMessage = "Penny is Thinking";
        } else if (_thinkingMessage.endsWith("..")) {
          _thinkingMessage = "Penny is Thinking...";
        } else if (_thinkingMessage.endsWith(".")) {
          _thinkingMessage = "Penny is Thinking..";
        } else {
          _thinkingMessage = "Penny is Thinking.";
        }

        // Update the last message in the list
        if (_messages.isNotEmpty &&
            _messages.last["content"]?.startsWith("Penny is Thinking") ==
                true) {
          _messages[_messages.length - 1]["content"] = _thinkingMessage;
        }
      });
    });
  }

  void _stopThinkingAnimation() {
    _thinkingTimer?.cancel();
    _thinkingTimer = null;
    _thinkingMessage = "Penny is Thinking";
  }

  @override
  void dispose() {
    _thinkingTimer?.cancel();
    super.dispose();
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
        backgroundColor: const Color(0xff37798c),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["role"] == "user";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(
                              0xffcb2b49) // Changed to #cb2b49 for user messages
                          : const Color.fromARGB(255, 55, 121, 140),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      message["content"] ?? "",
                      textAlign: isUser
                          ? TextAlign.right
                          : TextAlign.left, // Alignment for text
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
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
                    _controller.clear();
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
