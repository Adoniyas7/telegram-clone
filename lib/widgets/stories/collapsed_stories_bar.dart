// lib/widgets/stories/collapsed_stories_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/story_provider.dart';

class CollapsedStoriesBar extends StatelessWidget {
  final VoidCallback onTap;

  const CollapsedStoriesBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<StoryProvider>(context);
    final stories = storyProvider.stories;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        height: 70,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 180,
              ),
              child: Stack(
                children: [
                  for (var i = 0; i < stories.length; i++)
                    _buildStoryItem(
                      stories[i].userImage,
                      i,
                      storyProvider.isStoryViewed(stories[i].userId),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${stories.length} stories',
              style: const TextStyle(
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

  Widget _buildStoryItem(String imageUrl, int index, bool isViewed) {
    return Positioned(
      left: index * 25.0,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: !isViewed
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 255, 8),
                    Color.fromARGB(255, 0, 198, 70),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 133, 133, 133),
                    Color.fromARGB(255, 118, 118, 118),
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
