import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/constants/gradients.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientTitle extends StatelessWidget {
  final String text;
  const GradientTitle({super.key, this.text = "Trending this week"});

  @override
  Widget build(BuildContext context) {
    // base style used for measuring & child of ShaderMask
    final TextStyle textStyle = GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white, // child must be white for ShaderMask
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // left thin dash: transparent -> green (fades in toward center)
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            gradient: AppGradients.kDashInGradient.withOpacity(0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        const SizedBox(width: 8),

        // Gradient text: dark -> light
        // Use ShaderMask applied to the whole text widget
        LayoutBuilder(builder: (ctx, constraints) {
          return ShaderMask(
            shaderCallback: (bounds) {
              // create shader using the actual bounds width so gradient maps nicely
              return AppGradients.kTextGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              );
            },
            blendMode: BlendMode.srcIn,
            child: Text(
              text,
              style: textStyle,
            ),
          );
        }),

        const SizedBox(width: 8),

        // right thin dash: green -> transparent (fades out away from center)
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: AppGradients.kDashOutGradient.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}