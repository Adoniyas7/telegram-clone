import 'package:flutter/foundation.dart';
import '../models/story_model.dart';

class StoryProvider extends ChangeNotifier {
  final Map<String, bool> _viewedStories = {};
  final List<Story> _stories = [
    Story(
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
    ),
    Story(
      userId: '2',
      userName: 'Alice',
      userImage: 'https://picsum.photos/200',
      items: [
        StoryItem(
          url: 'https://picsum.photos/402/800',
          timestamp: DateTime.now(),
          type: StoryType.image,
        ),
      ],
      lastUpdated: DateTime.now(),
    ),
    Story(
      userId: '3',
      userName: 'Bob',
      userImage: 'https://picsum.photos/202',
      items: [
        StoryItem(
          url: 'https://picsum.photos/403/321',
          timestamp: DateTime.now(),
          type: StoryType.image,
        ),
      ],
      lastUpdated: DateTime.now(),
    ),
    Story(
      userId: '4',
      userName: 'Adoniyas',
      userImage: 'https://picsum.photos/279',
      items: [
        StoryItem(
          url: 'https://picsum.photos/403/100',
          timestamp: DateTime.now(),
          type: StoryType.image,
        ),
      ],
      lastUpdated: DateTime.now(),
    ),
    Story(
      userId: '5',
      userName: 'Abel',
      userImage: 'https://picsum.photos/299',
      items: [
        StoryItem(
          url: 'https://picsum.photos/403/21',
          timestamp: DateTime.now(),
          type: StoryType.image,
        ),
      ],
      lastUpdated: DateTime.now(),
    ),
    Story(
      userId: '6',
      userName: 'Sam',
      userImage: 'https://picsum.photos/21',
      items: [
        StoryItem(
          url: 'https://picsum.photos/234/21',
          timestamp: DateTime.now(),
          type: StoryType.image,
        ),
      ],
      lastUpdated: DateTime.now(),
    ),
  ];

  List<Story> get stories => _stories;
  bool isStoryViewed(String userId) => _viewedStories[userId] ?? false;

  void markStoryAsViewed(String userId) {
    _viewedStories[userId] = true;
    notifyListeners();
  }
}
