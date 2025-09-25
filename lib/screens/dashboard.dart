import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/screens/cubits/get_trending_images_cubit.dart';
import 'package:web_challenge/screens/cubits/theme_cubit.dart';
import 'package:web_challenge/services/pixabay_service.dart';
import 'package:web_challenge/widgets/image_card.dart';
import 'package:web_challenge/theme/text_styles.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeCubit, ThemeMode>(
       builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;

        final backgroundColor = isDark ? Colors.black : Colors.white;
        final textColor = isDark ? Colors.white70 : Colors.black87;
        final primaryColor = Theme.of(context).primaryColor;

        return BlocProvider(
          create: (_) =>
              TrendingImagesCubit(pixabayService: PixabayService())
                ..fetchTrendingImages(),
          child: Scaffold(
            backgroundColor:backgroundColor,
            body: BlocBuilder<TrendingImagesCubit, TrendingImagesState>(
              builder: (context, state) {
                if (state is TrendingImagesLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }

                if (state is TrendingImagesError) {
                  return Center(
                    child: Text(
                      "Error: ${state.error}",
                      style: AppTextStyles.bodyError.copyWith(
                        color: isDark ? Colors.redAccent : Colors.red,
                      ),
                    ),
                  );
                }

                if (state is TrendingImagesEmpty) {
                  return Center(
                    child: Text(
                      "No trending images found.",
                      style: AppTextStyles.emptyStateTitle.copyWith(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  );
                }

                if (state is TrendingImagesSuccess) {
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            isDark: isDark,
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
        );
      },
    );
  }
}
