import 'package:flutter/material.dart';

class ChannelList extends StatelessWidget {
  final List<String> channels;

  const ChannelList({Key? key, required this.channels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: channels.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.campaign),
          ),
          title: Text('Channel ${channels[index]}'),
          subtitle: const Text('Last post: 2 hours ago'),
          trailing: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('12:00', style: TextStyle(fontSize: 12)),
              Text('1.2K subscribers', style: TextStyle(fontSize: 12)),
            ],
          ),
          onTap: () {
            // Navigate to channel
          },
        );
      },
    );
  }
}
