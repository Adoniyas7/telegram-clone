import 'package:flutter/foundation.dart';
import '../models/story_model.dart';

class StoryProvider extends ChangeNotifier {
  final Map<String, bool> _viewedStories = {};

  bool isStoryViewed(String userId) => _viewedStories[userId] ?? false;

  void markStoryAsViewed(String userId) {
    _viewedStories[userId] = true;
    notifyListeners();
  }
}
