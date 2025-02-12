import 'package:flutter/material.dart';

class CollapsedStoriesBar extends StatelessWidget {
  final VoidCallback onTap;

  const CollapsedStoriesBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        height: 70,
        child: Row(
          mainAxisSize: MainAxisSize.min, // Makes the Row take minimum space
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 180,
              ),
              child: Stack(
                children: [
                  _buildStoryItem('https://picsum.photos/200', 0),
                  _buildStoryItem('https://picsum.photos/201', 1),
                  _buildStoryItem('https://picsum.photos/202', 2),
                  _buildStoryItem('https://picsum.photos/203', 3),
                  _buildStoryItem('https://picsum.photos/204', 4),
                  _buildStoryItem('https://picsum.photos/205', 5),
                ],
              ),
            ),
            const SizedBox(width: 1),
            Text(
              '6 stories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryItem(String imageUrl, int index) {
    return Positioned(
      left: index * 25.0, // Adjust the spacing between the circles
      child: Container(
        padding: const EdgeInsets.all(2), // Border width
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 255, 8),
              Color.fromARGB(255, 0, 198, 70),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
