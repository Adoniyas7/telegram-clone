// lib/models/story_model.dart
class Story {
  final String userId;
  final String userName;
  final String userImage;
  final List<StoryItem> items;
  final DateTime lastUpdated;
  bool isViewed;

  Story({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.items,
    required this.lastUpdated,
    this.isViewed = false,
  });

  void markAsViewed() {
    isViewed = true;
  }
}

class StoryItem {
  final String url;
  final DateTime timestamp;
  final StoryType type;

  StoryItem({
    required this.url,
    required this.timestamp,
    required this.type,
  });
}

enum StoryType { image, video }
