import 'package:flutter/material.dart';
import '../../constants/colors.dart';

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
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: hasStory && !isViewed
                    ? LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.secondaryBlue,
                        ],
                      )
                    : null,
                border: hasStory && isViewed
                    ? Border.all(color: AppColors.darkGrey, width: 2)
                    : null,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.lightGrey,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
