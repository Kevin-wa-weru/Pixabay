import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/screens/cubits/search_image_cubit.dart';
import 'package:web_challenge/screens/cubits/theme_cubit.dart';
import 'package:web_challenge/widgets/image_card.dart';
import 'package:web_challenge/theme/text_styles.dart'; // ✅ Import styles

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchImagesCubit>().searchImages(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;

        final backgroundColor = isDark ? Colors.black : Colors.white;
        final textColor = isDark ? Colors.white70 : Colors.black87;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // 🔎 Modern Floating Search Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    style: AppTextStyles.body.copyWith(
                      color: textColor,
                    ), // dynamic text color
                    decoration: InputDecoration(
                      hintText: "Search images (e.g., cats, cars)...",
                      hintStyle: AppTextStyles.body.copyWith(
                        color: isDark
                            ? Colors.white60
                            : Colors.black45, // dynamic hint color
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      filled: true,
                      fillColor: isDark
                          ? Colors.grey[850]
                          : Colors.grey[200], // dynamic fill
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) => _onSearchChanged(value, context),
                  ),
                ),

                // 📊 Content
                Expanded(
                  child: BlocBuilder<SearchImagesCubit, SearchImagesState>(
                    builder: (context, state) {
                      if (state is SearchImagesLoading) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                          itemCount: 9,
                          itemBuilder: (_, __) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        );
                      }

                      if (state is SearchImagesError) {
                        return Center(
                          child: Text(
                            "⚠️ ${state.error}",
                            style: AppTextStyles.bodyError, // ✅ Error style
                          ),
                        );
                      }

                      if (state is SearchImagesEmpty ||
                          state is SearchImagesInitial) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "No search yet",
                                style: AppTextStyles.emptyStateTitle.copyWith(
                                  color: textColor,
                                ),
                              ), // ✅ Title
                              const SizedBox(height: 8),
                              Text(
                                "Start typing above to explore millions of free images",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.emptyStateSubtitle
                                    .copyWith(color: textColor), // ✅ Subtitle
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is SearchImagesSuccess) {
                        final images = state.images;

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = 2;
                            if (constraints.maxWidth > 1200) {
                              crossAxisCount = 5;
                            } else if (constraints.maxWidth > 900) {
                              crossAxisCount = 4;
                            } else if (constraints.maxWidth > 600) {
                              crossAxisCount = 3;
                            }

                            return GridView.builder(
                              padding: const EdgeInsets.all(12),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.8,
                                  ),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                final img = images[index];
                                return ImageCard(
                                  imageUrl: img["webformatURL"] ?? "",
                                  user: img["user"] ?? "Unknown",
                                  tags: img["tags"] ?? "",
                                );
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 📸 Fullscreen Image Page
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
        child: Text(
          "📸 $user",
          style: AppTextStyles.body, // ✅ Reused style
        ),
      ),
    );
  }
}
