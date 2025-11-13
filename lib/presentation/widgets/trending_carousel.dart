import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingCarousel extends StatefulWidget {
  const TrendingCarousel({super.key});

  @override
  State<TrendingCarousel> createState() => _TrendingCarouselState();
}

class _TrendingCarouselState extends State<TrendingCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.70);

  double currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(2);
      _pageController.jumpToPage(1);
    });

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? _pageController.initialPage.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double _carouselHeight(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return max(300, min(420, h * 0.55));
  }

  @override
  Widget build(BuildContext context) {
    final height = _carouselHeight(context);

    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        padEnds: true,
        itemBuilder: (context, index) {
          final delta = (currentPage - index);
          final scale = (1 - delta.abs() * 0.13).clamp(0.86, 1.0);
          final opacity = (1 - delta.abs() * 0.5).clamp(0.45, 1.0);

          return Center(
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: Opacity(
                opacity: opacity,
                child: _buildCard(context),
              ),
            ),
          );
        },
      ),
    );
  }

  // card UI identical to your design
  Widget _buildCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.76,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // top image area
          Container(
            height: max(160, _cardImageHeight(context: context)),

          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sunday 21 August, 6:00PM onwards',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0A3F20).withValues(alpha: 0.65),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Nelangsa Randung\nin Delhi 2025',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    height: 1.28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),


                EventDivider(),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Phenoix Palassio, Lucknow',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.arrow_up_right,
                      size: 18,
                      color: Color(0xFF0FAE50),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  '₹ 1,999 Onwards',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _cardImageHeight({required BuildContext context}) {
    final h = MediaQuery.of(context).size.height;
    return min(220, max(160, h * 0.24));
  }
}

class EventDivider extends StatelessWidget {
  const EventDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.2,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF322F2F),
            Color(0xFF6E6E6E),
            Color(0xFFE6E3E3),
          ],
        ),
      ),
    );
  }
}
