import 'package:flutter/material.dart';
import 'package:web_challenge/theme/text_styles.dart';

class ImageCard extends StatefulWidget {
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
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            color: widget.isDark ? Colors.grey[900] : Colors.grey[200],
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: widget.isDark ? Colors.grey[800] : Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: widget.isDark ? Colors.grey[800] : Colors.grey[300],
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                      color: widget.isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          (widget.isDark ? Colors.black : Colors.black)
                              .withValues(alpha: _isHovered ? 0.75 : 0.6),
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
                        widget.user,
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
                        children: widget.tags
                            .split(",")
                            .take(3)
                            .map(
                              (tag) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.isDark
                                      ? Colors.black.withValues(alpha:  _isHovered ? 0.6 : 0.35,)
                                      : Colors.black.withValues(alpha:  _isHovered ? 0.5 : 0.25,),
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
          ),
        ),
      ),
    );
  }
}
