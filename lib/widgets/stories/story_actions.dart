import 'package:flutter/material.dart';

class StoryActions extends StatefulWidget {
  const StoryActions({Key? key}) : super(key: key);

  @override
  _StoryActionsState createState() => _StoryActionsState();
}

class _StoryActionsState extends State<StoryActions> {
  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white.withOpacity(0.1),
              ),
              child: const Row(
                children: [
                  Icon(Icons.emoji_emotions_outlined,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Reply privately...',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            icon: Icons.reply,
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.white,
            onPressed: _toggleLike,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.white,
  }) {
    return IconButton(
      icon: Icon(icon, color: color, size: 24),
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(
        width: 44,
        height: 44,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
