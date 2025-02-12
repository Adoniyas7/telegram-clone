import 'package:flutter/material.dart';
import 'chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyChats.length,
      itemBuilder: (context, index) {
        final chat = dummyChats[index];
        return ChatTile(
          name: chat['name']!,
          message: chat['message']!,
          time: chat['time']!,
          avatarUrl: chat['avatar']!,
          unreadCount: int.parse(chat['unread']!),
          isOnline: chat['online'] == 'true',
        );
      },
    );
  }

  static final List<Map<String, String>> dummyChats = [
    {
      'name': 'Alice Smith',
      'message': 'Hey! How are you doing?',
      'time': '12:30',
      'avatar': 'https://picsum.photos/200',
      'unread': '2',
      'online': 'true',
    },
    {
      'name': 'Flutter Group',
      'message': 'Bob: Check out this new feature!',
      'time': '11:45',
      'avatar': 'https://picsum.photos/201',
      'unread': '5',
      'online': 'false',
    },
    {
      'name': 'Carol Johnson',
      'message': 'The meeting is scheduled for tomorrow',
      'time': '10:20',
      'avatar': 'https://picsum.photos/202',
      'unread': '0',
      'online': 'true',
    },
    // Add more dummy chats as needed
  ];
}
