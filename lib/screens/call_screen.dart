import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  final String name;
  final String profileImage;

  const CallScreen({Key? key, required this.name, required this.profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF0A74DA)], // Gradient blue shades
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50), // Padding from top
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profileImage.startsWith('http')
                      ? NetworkImage(profileImage)
                      : AssetImage(profileImage) as ImageProvider,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Waiting...",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCallButton(Icons.volume_up, "Speaker", Colors.white),
                  _buildCallButton(Icons.videocam, "Start Video", Colors.white),
                  _buildCallButton(Icons.mic_off, "Mute", Colors.white),
                  _buildCallButton(Icons.call_end, "End Call", Colors.red, () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallButton(IconData icon, String label, Color color, [VoidCallback? onTap]) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          iconSize: 40,
          onPressed: onTap ?? () {},
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
