import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final bool isViewed;
  final bool hasStory;
  final bool isAdd;
  final VoidCallback onTap;

  const StoryCircle({
    Key? key,
    required this.imageUrl,
    required this.userName,
    this.isViewed = false,
    this.hasStory = true,
    this.isAdd = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: hasStory ? const EdgeInsets.all(4) : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: hasStory && !isViewed
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
                    border: hasStory && isViewed
                        ? Border.all(color: Colors.grey)
                        : null,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                if (isAdd)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.8),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
