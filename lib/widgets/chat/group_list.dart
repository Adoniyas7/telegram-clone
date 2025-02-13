import 'package:flutter/material.dart';
import 'chat_screen.dart'; // Import the ChatScreen

class GroupList extends StatelessWidget {
  final List<Map<String, dynamic>> groups = [
    {
      'name': 'Programming proj',
      'lastMessage': 'You: best.ico',
      'time': 'Apr 01',
      'imageUrl': 'https://example.com/group1.jpg',
      'isPinned': true,
      'isMuted': false,
      'unreadCount': 0,
    },
    {
      'name': 'BITS S.E. v2.016',
      'lastMessage': 'Amen: Also maths wxet ylekekal',
      'time': 'Apr 01',
      'imageUrl': 'https://example.com/group1.jpg',
      'isPinned': true,
      'isMuted': false,
      'unreadCount': 1,
    },
    {
      'name': 'Advanced Programming',
      'lastMessage': 'Meklit Cl added Abel',
      'time': 'Mar 16',
      'imageUrl': 'https://example.com/group2.jpg',
      'isMuted': false,
      'unreadCount': 0,
    },
    {
      'name': 'SE Internship',
      'lastMessage': 'Moan Bits: By the way this is the company...',
      'time': '09.07.23',
      'imageUrl': 'https://example.com/group3.jpg',
      'isMuted': true,
      'unreadCount': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text(group['name'][0], style: const TextStyle(fontSize: 20)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  group['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: group['isMuted'] ? Colors.grey : Colors.black,
                  ),
                ),
                Text(
                  group['time'],
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
            subtitle: Text(
              group['lastMessage'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            trailing: group['unreadCount'] > 0
                ? CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                    child: Text('${group['unreadCount']}', style: const TextStyle(fontSize: 12, color: Colors.white)),
                  )
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(groupName: group['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
