import 'package:flutter/material.dart';
import 'package:telegram_clone/models/story_model.dart';

class StoryContentView extends StatelessWidget {
  final StoryItem storyItem;

  const StoryContentView({
    Key? key,
    required this.storyItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(storyItem.url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
