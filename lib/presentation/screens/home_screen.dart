import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/services/quote_service.dart';
import '../../models/quote_model.dart';
import '../widgets/category_tabs.dart';
import '../widgets/get_plus_chip.dart';
import '../widgets/gradient_title.dart';
import '../widgets/location_widget.dart';
import '../widgets/quote_display_widget.dart';
import '../widgets/bottom_nav_bar.dart';

import '../widgets/trending_carousel.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  int selectedIndex = 0;

  final QuoteService _quoteService = QuoteService();
  bool _isLoadingQuote = false;
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loadInitialQuote();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialQuote() async {
    await _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    setState(() => _isLoadingQuote = true);
    _fabController.forward().then((_) => _fabController.reverse());

    try {
      final quote = await _quoteService.getRandomQuote();
      setState(() {
        _isLoadingQuote = false;
      });

      _showQuoteBottomSheet(quote);
    } catch (e) {
      setState(() => _isLoadingQuote = false);
    }
  }

  void _showQuoteBottomSheet(Quote quote) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => QuoteDisplayWidget(quote: quote),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeContent(
            selectedIndex: selectedIndex,
            onCategorySelected: (i) {
              setState(() => selectedIndex = i);
            },
          ),

          const ProfileScreen(),
          const ProfileScreen(),
          const ProfileScreen(),
          const ProfileScreen(),
        ],
      ),

      floatingActionButton: _currentIndex == 0
          ? RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_fabController),
        child: FloatingActionButton(
          onPressed: _isLoadingQuote ? null : _fetchQuote,
          backgroundColor: Color(0xFFE3879A),
          child: _isLoadingQuote
              ? const CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Color(0xFF3A1F2C)),
            strokeWidth: 2,
          )
              : const Icon(Icons.refresh, color: Color(0xFF3A1F2C)),
        ),
      )
          : null,

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}


class HomeContent extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const HomeContent({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return
    Container(
      color: const Color(0xFFE8E6E6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF5F6),
                    Color(0xFFFFCBD7),
                    Color(0xFFFFB3C3),
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [LocationWidget(), GetPlusChip()],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE2D5D7),
                            width: 1.1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 14),

                            Icon(
                              Icons.search,
                              size: 22,
                              color: const Color(0xFFB8B8B8),
                            ),

                            const SizedBox(width: 8),

                            Expanded(
                              child: TextField(
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                                cursorColor: Colors.grey.shade600,
                                decoration: InputDecoration(
                                  hintText: "Search for events",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFB8B8B8),
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF111111),
                                  Color(0xFF6E1F20),
                                  Color(0xFFBD392B),
                                ],
                                stops: [0.0, 0.55, 1.0],
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              );
                            },
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              "CENTRAL SQUARE",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF111111),
                                  Color(0xFF6E1F20),
                                  Color(0xFFBD392B),
                                ],
                                stops: [0.0, 0.55, 1.0],
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              );
                            },
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              "YOUR NEW\nADDRESS FOR\nGROWTH",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryTab(
                    icon: "assets/icons/music.png",
                    label: "Music",
                    isSelected: selectedIndex == 0,
                    onTap: () => onCategorySelected(0),
                  ),
                  const VerticalDividerWidget(),

                  CategoryTab(
                    icon: "assets/icons/standup.png",
                    label: "Standup",
                    isSelected: selectedIndex == 1,
                    onTap: () => onCategorySelected(1),
                  ),
                  const VerticalDividerWidget(),

                  CategoryTab(
                    icon: "assets/icons/poetry.png",
                    label: "Poetry",
                    isSelected: selectedIndex == 2,
                    onTap: () => onCategorySelected(2),
                  ),
                  const VerticalDividerWidget(),

                  CategoryTab(
                    icon: "assets/icons/theatre.png",
                    label: "Theatre",
                    isSelected: selectedIndex == 3,
                    onTap: () => onCategorySelected(3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GradientTitle(text: "Trending this week"),
            ),

            const SizedBox(height: 16),

            TrendingCarousel(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );

  }
}



// ICON GRADIENT: dark → light
const Gradient kIconGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF0A3F20),
    Color(0xFF23D96C),
  ],
);

// TEXT GRADIENT: light → dark (reverse)
const Gradient kTextGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF23D96C),
    Color(0xFF0A3F20),
  ],
);

// -------------------- ICON --------------------


// -------------------- TEXT --------------------



// /// Colors used
// const Color _kDarkGreen = Color(0xFF052512); // blackish green
// const Color _kLightGreen = Color(0xFF0F6C33); // light green
//
// /// Text gradient: DARK -> LIGHT (left -> right)
// const Gradient _kTextGradient = LinearGradient(
//   begin: Alignment.centerLeft,
//   end: Alignment.centerRight,
//   colors: [
//     _kDarkGreen,
//     _kLightGreen,
//   ],
// );

/// Dash gradient that fades IN from left edge (transparent -> green)


/// The final widget — use: GradientTitle()









