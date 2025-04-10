import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  Future<void> sendMessage(String question) async {
    setState(() {
      isLoading = true;
      messages.add({"user": question, "bot": "Typing..."}); // Temporary "Typing..."
    });

    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.22:5000/ask"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": question}),
      ).timeout(Duration(seconds: 300));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String botReply = responseData["bot"] ?? "No response from bot"; // Ensure botReply exists

        debugPrint("🟢 Bot Reply Displayed: $botReply");

        setState(() {
          isLoading = false;
          messages.removeLast(); // Remove "Typing..."
          messages.add({"user": question}); // Keep user message
          messages.add({"bot": botReply});  // Add actual bot response
        });
      } else {
        setState(() {
          isLoading = false;
          messages.removeLast();
          messages.add({"user": question});
          messages.add({"bot": "Error fetching response!"});
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.removeLast();
        messages.add({"user": question});
        messages.add({"bot": "Request timed out. Please try again."});
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("🟡 Back button pressed.");
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Color(0xFF4B0082),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        debugPrint("🟡 Navigating back...");
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/iconhead.png'),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Student Ease',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      bool isUser = message["user"] != null;

                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isUser)
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage('assets/bot.png'),
                              ),
                            if (!isUser) SizedBox(width: 10),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isUser ? Colors.grey[300] : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  message.containsKey("user") ? message["user"]! : message["bot"]!,
                                  style: TextStyle(color: Colors.black),
                                ),

                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (isLoading) CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'How can I help you......!!',
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                sendMessage(value);
                                _controller.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          if (_controller.text.isNotEmpty) {
                            sendMessage(_controller.text);
                            _controller.clear();
                          }
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
