import 'package:flutter/material.dart';
import 'package:user_explorer/core/constants/app_strings.dart';

class AppTopHeader extends StatelessWidget {
  const AppTopHeader({
    super.key,
    required this.title,
    this.showMenu = true,
    this.trailing,
  });

  final String title;
  final bool showMenu;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        if (showMenu)
          Icon(Icons.menu, color: colors.outline)
        else
          Icon(Icons.arrow_back_ios_new, size: 18, color: colors.onSurface),
        const SizedBox(width: 14),
        Text(
          title,
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        const Spacer(),
        trailing ??
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  AppStrings.jd,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
      ],
    );
  }
}
