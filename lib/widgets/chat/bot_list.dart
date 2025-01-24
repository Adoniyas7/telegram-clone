// bot_list.dart
import 'package:flutter/material.dart';

class BotList extends StatelessWidget {
  final List<Map<String, dynamic>> bots = [
    {
      'name': '@GitHubBot',
      'description': 'Get GitHub notifications',
      'imageUrl': 'https://picsum.photos/209',
    },
    // Add more bots...
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bots.length,
      itemBuilder: (context, index) {
        final bot = bots[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(bot['imageUrl']),
          ),
          title: Text(bot['name']),
          subtitle: Text(bot['description']),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
            // Navigate to bot chat
          },
        );
      },
    );
  }
}
