import 'package:flutter/material.dart';

class PowerSavingScreen extends StatefulWidget {
  const PowerSavingScreen({super.key});

  @override
  _PowerSavingScreenState createState() => _PowerSavingScreenState();
}

class _PowerSavingScreenState extends State<PowerSavingScreen> {
  bool powerSavingMode = false;
  double batteryThreshold = 10;
  bool animatedStickers = false;
  bool animatedEmoji = false;
  bool animationsInChats = true;
  bool animationsInCalls = false;
  bool autoplayVideos = false;
  bool autoplayGIFs = true;
  bool smoothTransitions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power Saving'),
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
          _buildHeader('Power Saving Mode'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Power Saving Mode OFF", style: TextStyle(fontWeight: FontWeight.bold)),
              Switch(
                value: powerSavingMode,
                onChanged: (value) {
                  setState(() {
                    powerSavingMode = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Off"),
              Expanded(
                child: Slider(
                  value: batteryThreshold,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: powerSavingMode
                      ? (value) {
                          setState(() {
                            batteryThreshold = value;
                          });
                        }
                      : null,
                ),
              ),
              const Text("On"),
            ],
          ),
          const Text(
            "Automatically reduce power usage and animations when your battery is below 10%.",
            style: TextStyle(color: Colors.grey),
          ),
          const Divider(height: 30),

          _buildHeader('Power saving options'),
          _buildToggleTile(Icons.sticky_note_2, 'Animated Stickers 0/2', animatedStickers, (value) {
            setState(() => animatedStickers = value);
          }),
          _buildToggleTile(Icons.emoji_emotions, 'Animated Emoji 0/3', animatedEmoji, (value) {
            setState(() => animatedEmoji = value);
          }),
          _buildToggleTile(Icons.chat_bubble_outline, 'Animations in Chats 1/5', animationsInChats, (value) {
            setState(() => animationsInChats = value);
          }),
          _buildToggleTile(Icons.call, 'Animations in Calls', animationsInCalls, (value) {
            setState(() => animationsInCalls = value);
          }),
          _buildToggleTile(Icons.video_library, 'Autoplay Videos', autoplayVideos, (value) {
            setState(() => autoplayVideos = value);
          }),
          _buildToggleTile(Icons.gif, 'Autoplay GIFs', autoplayGIFs, (value) {
            setState(() => autoplayGIFs = value);
          }),
          const Divider(height: 30),

          _buildHeader('Enable Smooth Transitions'),
          _buildToggleTile(Icons.animation, 'Enable Smooth Transitions', smoothTransitions, (value) {
            setState(() => smoothTransitions = value);
          }),
          const Text(
            "You can disable animated transitions between different sections of the app.",
            style: TextStyle(color: Colors.grey),
          ),
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

  Widget _buildToggleTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(!value),
    );
  }
}
