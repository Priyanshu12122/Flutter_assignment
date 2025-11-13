import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetPlusChip extends StatelessWidget {
  const GetPlusChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // compact pill
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // exact-ish left->right gradient sampled from your image
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF336135), // dark blackish-green (left)
            Color(0xFF0C9E08), // medium green (right)
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(22), // pill shape
        // subtle thin highlight border (very faint)
        border: Border.all(
          color: const Color(0xFF2C5E33).withOpacity(0.22),
          width: 0.8,
        ),
        boxShadow: [
          // tiny shadow so it sits off the background slightly
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // bolt icon — white and compact
          const Icon(Icons.flash_on, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            'Get Plus',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              // semi-bold: matches the screenshot weight
              fontSize: 13,
              height: 1.05,
              color: Colors.white,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

