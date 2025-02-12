import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataAndStorageScreen extends StatefulWidget {
  const DataAndStorageScreen({super.key});

  @override
  _DataAndStorageScreenState createState() => _DataAndStorageScreenState();
}

class _DataAndStorageScreenState extends State<DataAndStorageScreen> {
  bool mobileData = false;
  bool wifi = false;
  bool roaming = false;
  bool privateChats = false;
  bool groups = false;
  bool channels = false;
  bool streamVideos = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data and Storage'),
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
          _buildHeader('Disk and network usage'),
          _buildUsageTile(Icons.storage, 'Storage Usage', '147.2 MB'),
          _buildUsageTile(Icons.data_usage, 'Data Usage', '926.0 MB'),
          const Divider(height: 30),

          _buildHeader('Automatic media download'),
          _buildToggleTile('When using mobile data', mobileData, 'Disabled', (value) {
            setState(() => mobileData = value);
          }),
          _buildToggleTile('When connected to Wi-Fi', wifi, 'Disabled', (value) {
            setState(() => wifi = value);
          }),
          _buildToggleTile('When roaming', roaming, 'Disabled', (value) {
            setState(() => roaming = value);
          }),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text('Reset Auto-Download Settings', style: TextStyle(color: Colors.red)),
          ),
          const Divider(height: 30),

          _buildHeader('Save to Gallery'),
          _buildToggleTile('Private Chats', privateChats, 'Off', (value) {
            setState(() => privateChats = value);
          }),
          _buildToggleTile('Groups', groups, 'Off', (value) {
            setState(() => groups = value);
          }),
          _buildToggleTile('Channels', channels, 'Off', (value) {
            setState(() => channels = value);
          }),
          const Divider(height: 30),

          _buildHeader('Streaming'),
          _buildToggleTile('Stream Videos and Audio Files', streamVideos, '', (value) {
            setState(() => streamVideos = value);
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
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _buildUsageTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Text(value, style: const TextStyle(color: Colors.blue)),
      onTap: () {},
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
}
