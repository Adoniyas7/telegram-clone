import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class NewMessageScreen extends StatefulWidget {
  final String contactName;
  final Function(String) onMessageSent; // Function to send the message to HomeScreen

  const NewMessageScreen({Key? key, required this.contactName, required this.onMessageSent}) : super(key: key);

  @override
  _NewMessageScreenState createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  Timer? _timer; // Timer for counting seconds
  int _seconds = 0; // Counter for seconds
  bool _isRecording = false; // State variable for recording

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({"text": message, "time": "10:02", "isMe": true, "isVoiceMessage": false}); // Ensure all fields are set
      });
      _messageController.clear();
      widget.onMessageSent(message);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void initState() {
    super.initState();
    _messages.clear();
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _seconds = 0; // Reset seconds
    });

    // Start the timer to count seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopRecording() {
    _timer?.cancel(); // Stop the timer
    setState(() {
      _isRecording = false;
    });

    // Simulate sending a recorded message
    _sendRecordedMessage();
  }

  void _sendRecordedMessage() {
    final message = "Voice message sent"; // Indicate that a voice message was sent
    setState(() {
      _messages.add({
        "text": message,
        "time": "10:02",
        "isMe": true,
        "isVoiceMessage": true,
        "duration": _seconds, // Store the duration
      });
    });
    _scrollToBottom();
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 200,
          child: Column(
            children: [
              Text("Choose an option", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Photo'),
                onTap: () {
                  // Handle photo attachment
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.file_copy),
                title: Text('File'),
                onTap: () {
                  // Handle file attachment
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Location'),
                onTap: () {
                  // Handle location sharing
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.record_voice_over),
                title: Text('Voice Message'),
                onTap: () {
                  // Handle voice message
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/1.jpg"),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.contactName, style: const TextStyle(fontSize: 16)),
                const Text("online", style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message["isMe"] ?? false ? Alignment.centerRight : Alignment.centerLeft, // Use null-aware operator
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message["isMe"] ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: message["isMe"] ? const Radius.circular(15) : Radius.zero,
                        bottomRight: message["isMe"] ? Radius.zero : const Radius.circular(15),
                      ),
                    ),
                    child: message["isVoiceMessage"] // Check if it's a voice message
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.mic, color: message["isMe"] ? Colors.white : Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                "${message["duration"]} sec",
                                style: TextStyle(color: message["isMe"] ? Colors.white : Colors.black),
                              ),
                            ],
                          )
                        : Text(
                            message["text"],
                            style: TextStyle(
                              color: message["isMe"] ? Colors.white : Colors.black87,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: _showAttachmentOptions, // Show attachment options
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.grey,
                  ),
                  onPressed: _toggleRecording,
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          if (_isRecording) // Show recording time when recording
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recording: $_seconds seconds',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}