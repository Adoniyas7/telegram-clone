import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy and Security"),
      ),
      body: ListView(
        children: [
          _buildSectionTitle("Security"),
          _buildListTile("Two-Step Verification", "Off"),
          _buildListTile("Auto-Delete Messages", "Off"),
          _buildListTile("Passcode Lock", "Off"),
          _buildListTile("Blocked Users", "22"),
          _buildListTile("Devices", "3"),

          _buildSectionTitle("Privacy"),
          _buildListTile("Phone Number", "My Contacts"),
          _buildListTile("Last Seen & Online", "Everybody"),
          _buildListTile("Profile Photos", "Everybody"),
          _buildListTile("Forwarded Messages", "Everybody"),
          _buildListTile("Calls", "Everybody"),
          _buildListTile("Voice Messages", "Everybody"),
          _buildListTile("Messages", "Everybody"),
          _buildListTile("Date of Birth", "My Contacts"),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _buildListTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {},
    );
  }
}
