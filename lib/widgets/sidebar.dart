import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/screens/cubits/theme_cubit.dart';
import 'package:web_challenge/theme/text_styles.dart';

class SideBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const SideBar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Dashboard", "icon": Icons.dashboard_rounded},
      {"title": "Gallery", "icon": Icons.photo_library_rounded},
      {"title": "Profile", "icon": Icons.person_rounded},
    ];

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;

        final backgroundColor = isDark ? Colors.black : Colors.white;
        final textColor = isDark ? Colors.white70 : Colors.black87;
        final primaryColor = Theme.of(context).primaryColor;

        return Material(
          color: backgroundColor,
          child: Container(
            width: 240,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App title / branding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Pixabay App",
                    style: AppTextStyles.heading1.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Navigation items
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final isSelected = selectedIndex == i;

                      return InkWell(
                        onTap: () => onItemSelected(i),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryColor.withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                items[i]["icon"] as IconData,
                                color: isSelected ? primaryColor : textColor,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                items[i]["title"] as String,
                                style: AppTextStyles.body.copyWith(
                                  color: isSelected ? primaryColor : textColor,
                                  fontWeight:
                                      isSelected ? FontWeight.bold : FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Theme Switch
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark Mode",
                        style: AppTextStyles.body.copyWith(color: textColor),
                      ),
                      Switch(
                        value: isDark,
                        onChanged: (val) {
                          context.read<ThemeCubit>().toggleTheme(val);
                        },
                        activeColor: primaryColor,
                      ),
                    ],
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
