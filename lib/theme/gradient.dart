import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF7E7CE), // Bej deschis
            Color.fromARGB(255, 246, 244, 238), // Gri-albăstrui pal
          ],
        ),
      ),
      child: child,
    );
  }
}
