import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  final String name;
  final String profileImage;

  const CallScreen({Key? key, required this.name, required this.profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(profileImage), // Provide a valid image asset
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
          const SizedBox(height: 10),
          const Text(
            "Click on the Camera icon if you want to start a video call.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.videocam, color: Colors.blue),
                iconSize: 50,
                onPressed: () {
                  // Add functionality for video call
                },
              ),
              IconButton(
                icon: const Icon(Icons.cancel, color: Colors.red),
                iconSize: 50,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                iconSize: 50,
                onPressed: () {
                  // Add functionality for audio call
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
