import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_buddy/constants/app_color.dart';

import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _textController = TextEditingController();
  bool _isListening = false;
  bool _isTyping = false;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _loadMessagesFromPreferences(); // Load saved messages on initialization
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadMessagesFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMessages = prefs.getString('chat_messages');

    if (savedMessages != null) {
      final decodedMessages = jsonDecode(savedMessages) as List;
      setState(() {
        _messages
            .addAll(decodedMessages.map((e) => Map<String, String>.from(e)));
      });
    }
  }

  Future<void> _saveMessagesToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages = jsonEncode(_messages);
    await prefs.setString('chat_messages', encodedMessages);
  }

  Future<void> _sendMessage(String input) async {
    if (input.trim().isEmpty) return;

    String? text =
        "You are my nutritionist, guide me according to the text given below: \n + ${input.trim()}";

    setState(() {
      _messages.add({'text': input, 'sender': "user"});
      _isTyping = true;
    });

    _textController.clear();
    await _saveMessagesToPreferences(); // Save messages after user input

    const String togetherApiKey =
        "your_together_api_key";

    try {
      final response = await http.post(
        Uri.parse('https://api.together.xyz/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $togetherApiKey',
        },
        body: jsonEncode({
          'model': 'meta-llama/Meta-Llama-3.1-8B-Instruct-Turbo',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful gym mentor.'},
            {'role': 'user', 'content': text},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final assistantMessage = data['choices'][0]['message']['content'];

        setState(() {
          _messages.add({'text': assistantMessage, 'sender': 'assistant'});
        });

        await _saveMessagesToPreferences(); // Save messages after bot response
      } else {
        throw Exception('Failed to fetch response');
      }
    } catch (error) {
      setState(() {
        _messages.add({
          'text': "I'm sorry, I couldn't process your request at the moment.",
          "sender": "assistant"
        });
      });
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        title: const Text(
          'Diet Assistant',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: Column(
          children: [
            // Chat display
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    // Typing indicator
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(3, (dotIndex) {
                            return AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: (dotIndex ==
                                          (_animationController.value * 3)
                                                  .floor() %
                                              3)
                                      ? 1
                                      : 0.3,
                                  child: const Text(
                                    '.',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    );
                  }

                  final message = _messages[index];
                  final isUser = message['sender'] == 'user';

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blueGrey[800] : Colors.grey[850],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 0),
                          bottomRight: Radius.circular(isUser ? 0 : 16),
                        ),
                      ),
                      child: Text(
                        message['text']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Input field at the bottom
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, -2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        filled: true,
                        fillColor: AppColors.cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.blueAccent),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.all(13),
                      ),
                    ),
                    onPressed: () => _sendMessage(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
