import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String groupName;

  ChatScreen({required this.groupName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'sender': 'Alice Smith', 'text': 'I think it is because of the button frame', 'time': '5:40 PM', 'isMe': false},
    {'sender': 'Alice Smith', 'text': 'The fixed one', 'time': '5:57 PM', 'isMe': false},
    {'sender': 'Alice Smith', 'text': 'Zoom keminigeba nege tehwat dersen bine zegaj yishala a?', 'time': '7:11 PM', 'isMe': false},
    {'sender': 'Alice Smith', 'text': 'Yaaaa egna sfr mebrat yelem', 'time': '7:20 PM', 'isMe': false},
    {'sender': 'Abebe Kebede', 'text': 'Okay', 'time': '7:39 PM', 'isMe': false},
    {'sender': 'John Doe', 'text': 'Forwarded the Files', 'time': '10:47 AM', 'isMe': true},
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return; // Prevent sending empty messages

    setState(() {
      messages.add({
        'sender': 'John Doe', // Show "John Doe" as the sender for every sent message
        'text': _messageController.text.trim(),
        'time': TimeOfDay.now().format(context), // Show the current time
        'isMe': true, // Indicate it's the sender's message
      });
      _messageController.clear(); // Clear input field after sending
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.groupName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isJohnDoe = message['sender'] == 'John Doe';

                return Container(
                  alignment: isJohnDoe ? Alignment.centerRight : Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isJohnDoe ? Colors.green[50] : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft: isJohnDoe ? const Radius.circular(10) : Radius.zero,
                        bottomRight: isJohnDoe ? Radius.zero : const Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(message['sender'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), // Always show sender name
                        Text(message['text'], style: const TextStyle(fontSize: 14)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(message['time'], style: const TextStyle(fontSize: 10, color: Colors.black54)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(hintText: 'Type a message...', border: InputBorder.none),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage, // Send message when clicked
          ),
        ],
      ),
    );
  }
}
