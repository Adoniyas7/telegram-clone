import 'package:flutter/material.dart';

class ChatSettingsScreen extends StatelessWidget {
  const ChatSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Settings'),
        backgroundColor: const Color(0xFF2AABEE),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Message text size',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const Text('16'),
              ],
            ),
          ),
          Slider(
            value: 16,
            min: 10,
            max: 30,
            onChanged: (value) {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Change Chat Wallpaper'),
            leading: const Icon(Icons.image),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Change Name Color'),
            leading: const Icon(Icons.color_lens),
            onTap: () {},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Color Theme',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorTheme(Colors.green),
              _buildColorTheme(Colors.yellow),
              _buildColorTheme(Colors.blue),
              _buildColorTheme(Colors.purple),
            ],
          ),
          const Divider(),
          ListTile(
            title: const Text('Switch to Night Mode'),
            leading: const Icon(Icons.nightlight_round),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Browse Themes'),
            leading: const Icon(Icons.palette),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildColorTheme(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
