import 'package:flutter/material.dart';
import 'package:telegram_clone/widgets/stories/story_circle.dart';
import '../../screens/story_viewer_screen.dart';
import '../../models/story_model.dart';

class ExpandedStoriesBar extends StatelessWidget {
  const ExpandedStoriesBar({Key? key}) : super(key: key);

  void _openStory(BuildContext context, Story story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewerScreen(story: story),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sampleStory = Story(
      userId: '1',
      userName: 'John',
      userImage: 'https://picsum.photos/201',
      items: [
        StoryItem(
          url: 'https://picsum.photos/400/800',
          timestamp: DateTime.now(),
          type: StoryType.image,
        ),
        StoryItem(
          url: 'https://picsum.photos/401/800',
          timestamp: DateTime.now(),
          type: StoryType.image,
        ),
      ],
      lastUpdated: DateTime.now(),
    );

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          StoryCircle(
            imageUrl: '',
            userName: 'Add Story',
            hasStory: false,
            isAdd: true,
            onTap: () {},
          ),
          StoryCircle(
            imageUrl: 'https://picsum.photos/200',
            userName: 'Your Story',
            hasStory: false,
            isAdd: false,
            onTap: () => _openStory(context, sampleStory),
          ),
          StoryCircle(
            imageUrl: 'https://picsum.photos/201',
            userName: 'John',
            hasStory: true,
            isAdd: false,
            onTap: () => _openStory(context, sampleStory),
          ),
        ],
      ),
    );
  }
}
