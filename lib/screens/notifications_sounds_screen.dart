import 'package:flutter/material.dart';

class NotificationsSoundsScreen extends StatefulWidget {
  const NotificationsSoundsScreen({super.key});

  @override
  _NotificationsSoundsScreenState createState() => _NotificationsSoundsScreenState();
}

class _NotificationsSoundsScreenState extends State<NotificationsSoundsScreen> {
  bool allAccounts = true;
  bool privateChats = false;
  bool groups = false;
  bool channels = false;
  bool stories = false;
  bool reactions = true;
  bool showBadgeIcon = true;
  bool includeMutedChats = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications and Sounds'),
        backgroundColor: const Color(0xFF2AABEE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader('Show notifications from'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('All Accounts', style: TextStyle(fontSize: 16)),
              Switch(
                value: allAccounts,
                onChanged: (value) => setState(() => allAccounts = value),
              ),
            ],
          ),
          const Text(
            'Turn this off if you want to receive notifications only from the account you are currently using.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const Divider(height: 30),

          _buildHeader('Notifications for chats'),
          _buildToggleTile('Private Chats', privateChats, 'Off, 44 exceptions', (value) {
            setState(() => privateChats = value);
          }),
          _buildToggleTile('Groups', groups, 'Off, 10 exceptions', (value) {
            setState(() => groups = value);
          }),
          _buildToggleTile('Channels', channels, 'Off, 6 exceptions', (value) {
            setState(() => channels = value);
          }),
          _buildToggleTile('Stories', stories, 'Off, 6 exceptions', (value) {
            setState(() => stories = value);
          }),
          _buildToggleTile('Reactions', reactions, 'Messages, Stories', (value) {
            setState(() => reactions = value);
          }),
          const Divider(height: 30),

          _buildHeader('Calls'),
          _buildSimpleTile('Vibrate', 'Default'),
          _buildSimpleTile('Ringtone', 'Default'),
          const Divider(height: 30),

          _buildHeader('Badge Counter'),
          _buildToggleTile('Show Badge Icon', showBadgeIcon, '', (value) {
            setState(() => showBadgeIcon = value);
          }),
          _buildToggleTile('Include Muted Chats', includeMutedChats, '', (value) {
            setState(() => includeMutedChats = value);
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildToggleTile(String title, bool value, String subtitle, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: const TextStyle(color: Colors.grey)) : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(!value),
    );
  }

  Widget _buildSimpleTile(String title, String trailingText) {
    return ListTile(
      title: Text(title),
      trailing: Text(trailingText, style: const TextStyle(color: Colors.grey)),
      onTap: () {},
    );
  }
}
