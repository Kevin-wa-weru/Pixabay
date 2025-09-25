import 'package:flutter/material.dart';
import 'package:web_challenge/theme/text_styles.dart';

class FullscreenImage extends StatelessWidget {
  final String imageUrl;
  final String user;

  const FullscreenImage({
    super.key,
    required this.imageUrl,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: InteractiveViewer(
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black54,
        child: Text("📸 $user", style: AppTextStyles.body),
      ),
    );
  }
}
