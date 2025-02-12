import 'package:flutter/material.dart';
import 'package:telegram_clone/models/story_model.dart';
import 'package:telegram_clone/widgets/stories/story_actions.dart';
import 'package:telegram_clone/widgets/stories/story_content_view.dart';
import 'package:telegram_clone/widgets/stories/story_header.dart';
import 'package:telegram_clone/widgets/stories/story_progress_bar.dart';
import 'package:provider/provider.dart';
import '../providers/story_provider.dart';

class StoryViewerScreen extends StatefulWidget {
  final Story story;

  const StoryViewerScreen({
    super.key,
    required this.story,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animationController.addStatusListener(_animationStatusListener);
    _animationController.forward();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _nextStory();
    }
  }

  void _nextStory() {
    if (_currentIndex < widget.story.items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // Mark the story as viewed when the screen is closed
    widget.story.markAsViewed();
    Provider.of<StoryProvider>(context, listen: false)
        .markStoryAsViewed(widget.story.userId);
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            // Tap on left side - go to previous story
            if (_currentIndex > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          } else {
            // Tap on right side - go to next story
            _nextStory();
          }
        },
        child: Stack(
          children: [
            // Story Content
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.story.items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _animationController
                    ..reset()
                    ..forward();
                });
              },
              itemBuilder: (context, index) {
                final item = widget.story.items[index];
                return StoryContentView(storyItem: item);
              },
            ),
            // Progress Bars
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(
                  widget.story.items.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: StoryProgressBar(
                        animation: _animationController,
                        isActive: index == _currentIndex,
                        isPast: index < _currentIndex,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // User Info
            Positioned(
              top: MediaQuery.of(context).padding.top + 40,
              left: 10,
              right: 10,
              child: StoryHeader(
                userName: widget.story.userName,
                userImage: widget.story.userImage,
                timestamp: widget.story.items[_currentIndex].timestamp,
                onClose: () => Navigator.pop(context),
              ),
            ),
            // Story Actions
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: StoryActions(),
            ),
          ],
        ),
      ),
    );
  }
}
