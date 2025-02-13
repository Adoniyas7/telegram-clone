import 'package:flutter/material.dart';
import 'channel_detail_screen.dart';
import 'package:telegram_clone/constants/colors.dart'; // Import the new screen

class NewChannelScreen extends StatelessWidget {
  const NewChannelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change background to white
      appBar: AppBar(
        title: const Text('New Channel'),
        backgroundColor: Colors.blue, // Keep the AppBar color as needed
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Channel image placeholder
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent, // Placeholder color
                ),
                child: const Center(
                  child: Text(
                    'Channel',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'What is a Channel?',
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), // Change text color to black
              ),
              const SizedBox(height: 10),
              const Text(
                'Channels are a one-to-many tool for broadcasting your messages to unlimited audiences.',
                style: TextStyle(color: Colors.black, fontSize: 16), // Change text color to black
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the ChannelDetailScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChannelDetailScreen()),
                  );
                },
                // ignore: sort_child_properties_last
                child: const Text('Create Channel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue, // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}