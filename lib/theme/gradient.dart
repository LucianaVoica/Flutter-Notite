import 'package:flutter/material.dart';

import 'app_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AppColors.secondaryLight,
            Color.fromARGB(255, 246, 244, 238),
          ],
        ),
      ),
      child: child,
    );
  }
}
