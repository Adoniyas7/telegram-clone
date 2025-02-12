import 'package:flutter/material.dart';
import 'chat_settings_screen.dart';
import 'privacy_security_screen.dart';
import 'notifications_sounds_screen.dart';
import 'data_storage_screen.dart';
import 'power_saving_screen.dart';

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
            padding: const EdgeInsets.all(5),
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
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                    Text('Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),),
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
                    Text('Username',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                     '@johndoe',
                     style: TextStyle(color: Colors.white),
                   ),
                   ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                    Text('Bio                                                                                                         ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
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
              children: [
                ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text('Chat Settings'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatSettingsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Privacy and Security'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PrivacySecurityScreen()),
    );
  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications and Sounds'),
                  trailing: Icon(Icons.chevron_right),
                   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationsSoundsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.data_usage),
                  title: Text('Data and Storage'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataAndStorageScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.battery_saver),
                  title: Text('Power Saving'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PowerSavingScreen()),
                    );
                  },
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
