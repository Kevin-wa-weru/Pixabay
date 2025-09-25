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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Pixabay App",
                    style: AppTextStyles.heading1.copyWith(color: primaryColor),
                  ),
                ),
                const SizedBox(height: 30),

                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final isSelected = selectedIndex == i;
                      return _HoverableSidebarItem(
                        title: items[i]["title"] as String,
                        icon: items[i]["icon"] as IconData,
                        isSelected: isSelected,
                        primaryColor: primaryColor,
                        textColor: textColor,
                        onTap: () => onItemSelected(i),
                      );
                    },
                  ),
                ),

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

class _HoverableSidebarItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Color primaryColor;
  final Color textColor;
  final VoidCallback onTap;

  const _HoverableSidebarItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.primaryColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  State<_HoverableSidebarItem> createState() => _HoverableSidebarItemState();
}

class _HoverableSidebarItemState extends State<_HoverableSidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isSelected
        ? widget.primaryColor.withValues(alpha: 0.2)
        : _isHovered
            ? widget.primaryColor.withValues(alpha: 0.1)
            : Colors.transparent;

    final iconColor =
        widget.isSelected ? widget.primaryColor : widget.textColor;

    final textColor =
        widget.isSelected ? widget.primaryColor : widget.textColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              AnimatedScale(
                scale: _isHovered ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: Icon(widget.icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                style: AppTextStyles.body.copyWith(
                  color: textColor,
                  fontWeight: widget.isSelected || _isHovered
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 15,
                ),
                child: Text(widget.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
