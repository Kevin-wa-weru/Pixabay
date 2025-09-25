import 'package:flutter/material.dart';
import 'package:web_challenge/theme/text_styles.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String user;
  final String tags;
  final bool isDark; 

  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.user,
    required this.tags,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      color: isDark ? Colors.grey[900] : Colors.grey[200],
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: isDark ? Colors.grey[800] : Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: isDark ? Colors.grey[800] : Colors.grey[300],
              child: Icon(
                Icons.broken_image,
                size: 40,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    (isDark ? Colors.black : Colors.black).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: AppTextStyles.heading1.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                Wrap(
                  spacing: 6,
                  runSpacing: -8,
                  children: tags
                      .split(",")
                      .take(3)
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.35)
                                : Colors.black..withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tag.trim(),
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
