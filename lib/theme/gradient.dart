import 'package:flutter/material.dart';

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
            Color(0xFFF7E7CE),
            Color.fromARGB(255, 246, 244, 238),
          ],
        ),
      ),
      child: child,
    );
  }
}
