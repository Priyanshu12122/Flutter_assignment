import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Gradient gradient;

  const GradientIcon({
    super.key,
    required this.asset,
    required this.size,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, size, size)),
      blendMode: BlendMode.srcIn,
      child: Image.asset(
        asset,
        width: size,
        height: size,
        color: Colors.white, // required for gradient
      ),
    );
  }
}