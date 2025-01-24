import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  final List<Map<String, dynamic>> groups = [
    {
      'name': 'Flutter Developers',
      'lastMessage': 'Check out this new widget!',
      'time': '12:30',
      'imageUrl': 'https://example.com/group1.jpg',
      'memberCount': 1234,
    },
    // Add more groups...
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(group['imageUrl']),
          ),
          title: Text(group['name']),
          subtitle: Text(group['lastMessage']),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(group['time'], style: const TextStyle(fontSize: 12)),
              Text('${group['memberCount']} members',
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
          onTap: () {
            // Navigate to group chat
          },
        );
      },
    );
  }
}
