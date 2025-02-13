import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telegram_clone/models/contact_model.dart';
import 'package:telegram_clone/screens/profile_screen.dart';
import 'package:telegram_clone/widgets/file_attachment.dart';
import 'call_screen.dart';
import 'dart:async'; // Import for Timer

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final Function(String)? onMessageSent;

  const ChatDetailScreen({
    Key? key,
    required this.name,
    required this.avatarUrl,
    required this.isOnline,
    this.onMessageSent,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _seconds = 0;
  bool _isRecording = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello!',
      'isMe': false,
      'time': '10:00',
      'reactions': <String>[],
      'isVoiceMessage': false,
    },
    {
      'text': 'Hi there!',
      'isMe': true,
      'time': '10:01',
      'reactions': <String>[],
      'isVoiceMessage': false,
    },
  ];

  @override
  void dispose() {
    _timer?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': message,
          'isMe': true,
          'time': _getCurrentTime(),
          'reactions': <String>[],
          'isVoiceMessage': false,
        });
      });
      _messageController.clear();
      widget.onMessageSent?.call(message);
      _scrollToBottom();
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _addReaction(int messageIndex, String reaction) {
    setState(() {
      List<String> reactions =
          List<String>.from(_messages[messageIndex]['reactions']);
      if (reactions.contains(reaction)) {
        reactions.remove(reaction);
      } else {
        reactions.add(reaction);
      }
      _messages[messageIndex]['reactions'] = reactions;
    });
  }

  void _showMessageOptions(BuildContext context, int messageIndex) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _MessageOptionsSheet(
        onReactionSelected: (reaction) {
          Navigator.pop(context);
          _addReaction(messageIndex, reaction);
        },
        onCopy: () {
          Navigator.pop(context);
          Clipboard.setData(
              ClipboardData(text: _messages[messageIndex]['text']));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message copied to clipboard')),
          );
        },
        onReply: () {
          Navigator.pop(context);
          // Implement reply functionality
        },
        onForward: () {
          Navigator.pop(context);
          // Implement forward functionality
        },
        onDelete: () {
          Navigator.pop(context);
          setState(() {
            _messages.removeAt(messageIndex);
          });
        },
      ),
    );
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
      _seconds = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _messages.add({
        'text': 'Voice message',
        'isMe': true,
        'time': _getCurrentTime(),
        'reactions': <String>[],
        'isVoiceMessage': true,
        'duration': _seconds,
      });
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  contact: Contact(
                    id: '1',
                    name: widget.name,
                    avatarUrl: widget.avatarUrl,
                    isOnline: widget.isOnline,
                    phoneNumber: '',
                  ),
                ),
              ),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.avatarUrl),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name),
                  Text(
                    widget.isOnline ? 'online' : 'offline',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    name: widget.name,
                    profileImage: widget.avatarUrl,
                  ),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              // Handle action based on the selected value
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      contact: Contact(
                        id: '1',
                        name: widget.name,
                        avatarUrl: widget.avatarUrl,
                        isOnline: widget.isOnline,
                        phoneNumber: '',
                      ),
                    ),
                  ),
                );
              } else if (value == 'mute') {
                // Handle mute action
                print('Muted chat');
              } else if (value == 'delete') {
                // Handle delete action
                print('Deleted chat');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('View Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'mute',
                  child: Text('Mute Chat'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete Chat'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                  reactions: List<String>.from(message['reactions']),
                  isVoiceMessage: message['isVoiceMessage'] ?? false,
                  duration: message['duration'],
                  onLongPress: () => _showMessageOptions(context, index),
                );
              },
            ),
          ),
          if (_isRecording)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recording: $_seconds seconds',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          FileAttachmentWidget(
            onFilePicked: (type, path, name) {
              setState(() {
                _messages.add({
                  'text': 'File: $name',
                  'isMe': true,
                  'time': _getCurrentTime(),
                  'reactions': <String>[],
                  'isVoiceMessage': false,
                });
              });
              _scrollToBottom();
            },
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
            icon: Icon(_isRecording ? Icons.stop : Icons.mic),
            onPressed: _toggleRecording,
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final List<String> reactions;
  final bool isVoiceMessage;
  final int? duration;
  final VoidCallback onLongPress;

  const _MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
    required this.reactions,
    required this.onLongPress,
    this.isVoiceMessage = false,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (isVoiceMessage)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.mic,
                                  color: isMe ? Colors.white : Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                "$duration sec",
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            text,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                        const SizedBox(height: 2),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe ? Colors.white70 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (reactions.isNotEmpty)
              Positioned(
                bottom: 10,
                right: isMe ? null : 37,
                left: isMe ? 10 : null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...reactions.map((emoji) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Text(emoji,
                                style: const TextStyle(fontSize: 10)),
                          )),
                      Container(
                        padding: const EdgeInsets.only(left: 1),
                        margin: const EdgeInsets.only(left: 1),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MessageOptionsSheet extends StatelessWidget {
  final Function(String) onReactionSelected;
  final VoidCallback onCopy;
  final VoidCallback onReply;
  final VoidCallback onForward;
  final VoidCallback onDelete;

  const _MessageOptionsSheet({
    required this.onReactionSelected,
    required this.onCopy,
    required this.onReply,
    required this.onForward,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildReactionButton('👍', context),
                _buildReactionButton('❤️', context),
                _buildReactionButton('😂', context),
                _buildReactionButton('😮', context),
                _buildReactionButton('😢', context),
                _buildReactionButton('👏', context),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.reply),
            title: const Text('Reply'),
            onTap: onReply,
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copy'),
            onTap: onCopy,
          ),
          ListTile(
            leading: const Icon(Icons.forward),
            title: const Text('Forward'),
            onTap: onForward,
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: onDelete,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildReactionButton(String emoji, BuildContext context) {
    return GestureDetector(
      onTap: () => onReactionSelected(emoji),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
