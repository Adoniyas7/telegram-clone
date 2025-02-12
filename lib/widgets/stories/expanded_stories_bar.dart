import 'package:flutter/material.dart';
import 'package:telegram_clone/widgets/stories/story_circle.dart';
import '../../screens/story_viewer_screen.dart';
import '../../models/story_model.dart';
import 'package:provider/provider.dart';
import '../../providers/story_provider.dart';

class ExpandedStoriesBar extends StatelessWidget {
  const ExpandedStoriesBar({Key? key}) : super(key: key);

  void _openStory(BuildContext context, Story story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewerScreen(story: story),
      ),
    ).then((_) {
      Provider.of<StoryProvider>(context, listen: false)
          .markStoryAsViewed(story.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<StoryProvider>(context);
    final stories = storyProvider.stories;

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
          ...stories.map((story) => StoryCircle(
                imageUrl: story.userImage,
                userName: story.userName,
                hasStory: true,
                isViewed: storyProvider.isStoryViewed(story.userId),
                onTap: () => _openStory(context, story),
              )),
        ],
      ),
    );
  }
}
