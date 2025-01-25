import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telegram_clone/models/contact_model.dart';
import 'package:telegram_clone/screens/profile_screen.dart';
import 'package:telegram_clone/widgets/file_attachment.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String avatarUrl;
  final bool isOnline;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.isOnline,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello!',
      'isMe': false,
      'time': '10:00',
      'reactions': <String>[],
    },
    {
      'text': 'Hi there!',
      'isMe': true,
      'time': '10:01',
      'reactions': <String>[],
    },
    {
      'text': 'How are you?',
      'isMe': false,
      'time': '10:01',
      'reactions': <String>[],
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            GestureDetector(
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
                        phoneNumber: '1234567890',
                      ),
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.avatarUrl),
              ),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                  reactions: List<String>.from(message['reactions']),
                  onLongPress: () => _showMessageOptions(context, index),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
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

  bool _isRecording = false;

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
          if (!_isRecording)
            FileAttachmentWidget(
              onFilePicked: (type, path, name) {
                setState(() {
                  _messages.add({
                    'type': type,
                    'filePath': path,
                    'fileName': name,
                    'isMe': true,
                    'time': DateTime.now().toString(),
                    'reactions': <String>[],
                  });
                });
              },
            ),
          if (!_isRecording)
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Message',
                  border: InputBorder.none,
                ),
              ),
            ),
          if (_isRecording)
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                setState(() {
                  _isRecording = false;
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () {
                setState(() {
                  _isRecording = true;
                });
              },
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
  final VoidCallback onLongPress;

  const _MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
    required this.reactions,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      isMe ? Theme.of(context).primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
              if (reactions.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: reactions
                        .map((emoji) =>
                            Text(emoji, style: const TextStyle(fontSize: 12)))
                        .toList(),
                  ),
                ),
            ],
          ),
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
