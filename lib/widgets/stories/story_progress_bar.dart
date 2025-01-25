import 'package:flutter/material.dart';

class StoryProgressBar extends StatelessWidget {
  final AnimationController animation;
  final bool isActive;
  final bool isPast;

  const StoryProgressBar({
    Key? key,
    required this.animation,
    required this.isActive,
    required this.isPast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          height: 2,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(1),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: isPast
                ? 1.0
                : isActive
                    ? animation.value
                    : 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        );
      },
    );
  }
}
