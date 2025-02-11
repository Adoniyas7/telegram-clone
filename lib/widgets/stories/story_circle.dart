import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final bool isViewed;
  final bool hasStory;
  final VoidCallback onTap;

  const StoryCircle({
    Key? key,
    required this.imageUrl,
    required this.userName,
    this.isViewed = false,
    this.hasStory = true,
    required this.onTap,
    required bool isAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: hasStory && !isViewed
                    ? LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 0, 255, 8),
                          const Color.fromARGB(255, 0, 198, 70),
                        ],
                      )
                    : LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 133, 133, 133),
                          const Color.fromARGB(255, 118, 118, 118),
                        ],
                      ),
                border: hasStory && isViewed
                    ? Border.all(color: Colors.grey)
                    : null,
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            const SizedBox(height: 1),
            Flexible(
              child: Text(
                userName,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
