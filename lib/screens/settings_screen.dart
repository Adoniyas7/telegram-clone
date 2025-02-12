import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFF2AABEE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF2AABEE),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile.jpg'), // Change to your image asset
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'online',
                          style: TextStyle(color: Color(0xFF90EE90)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                    Text('Phone Number'),
                    Text(
                     '+12345678900',
                     style: TextStyle(color: Colors.white),
                   ),
                   ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                    Text('Username'),
                    Text(
                     '@johndoe',
                     style: TextStyle(color: Colors.white),
                   ),
                   ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                    Text('Bio'),
                    Text(
                     "It's a sad truth that those who shine brightest often burn fastest.",
                     style: TextStyle(color: Colors.white),
                   ),
                   ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.chat),
                  title: Text('Chat Settings'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Privacy and Security'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications and Sounds'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.data_usage),
                  title: Text('Data and Storage'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.battery_saver),
                  title: Text('Power Saving'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.folder),
                  title: Text('Chat Folders'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.devices),
                  title: Text('Devices'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  trailing: Text('English', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
