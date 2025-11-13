import 'package:flutter/material.dart';
import '../../models/quote_model.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/gradients.dart';

class QuoteDisplayWidget extends StatelessWidget {
  final Quote quote;

  const QuoteDisplayWidget({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      decoration: const BoxDecoration(
        gradient: AppGradients.header,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.format_quote,
              color: AppColors.deepPlum,
              size: 32,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            '"${quote.quote}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.deepPlum,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '- ${quote.author}',
              style: const TextStyle(
                color: Color(0xFF7B4A5A),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 22),
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: AppColors.deepPlum),
            label: const Text(
              'Close',
              style: TextStyle(
                color: AppColors.deepPlum,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.45),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
