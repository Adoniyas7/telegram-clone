import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2AABEE)),
            accountName: Text('John Doe'),
            accountEmail: Text('+1 234 567 8900'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications and Sounds'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacy and Security'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Data and Storage'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text('Chat Settings'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Chat Folders'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'NEW',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Telegram FAQ'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
