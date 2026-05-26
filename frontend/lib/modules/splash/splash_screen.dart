import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart'; // To navigate to HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  // Animation sub-states
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _cardFadeAnimation;
  late Animation<Offset> _cardSlideAnimation;
  late Animation<double> _buttonFadeAnimation;
  
  // Button interactive scale state
  double _buttonScale = 1.0;

  @override
  void initState() {
    super.initState();
    
    // Core animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    // 1. Logo Animation (0% to 50% of timeline)
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // 2. Offer Card Animation (30% to 80% of timeline)
    _cardFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );
    _cardSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.25), // Slide up from below
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.fastOutSlowIn),
      ),
    );

    // 3. Button and Footer Animation (60% to 100% of timeline)
    _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    // Trigger animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBEF), // Serene light-green/off-white background
      body: Stack(
        children: [
          // 1. Background Dot Pattern
          Positioned.fill(
            child: CustomPaint(
              painter: DotPatternPainter(),
            ),
          ),
          
          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  
                  // Brand Logo & Centerpiece (Animated)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoFadeAnimation.value,
                        child: Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            width: 260,
                            height: 260,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(
                              'lib/assets/LifeHerba Logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                // Dynamic offline vector fallback
                                return Center(
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF0E4), // surface-container
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFFBFCAB8), // outline-variant
                                        width: 1,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.eco_rounded,
                                      color: Color(0xFF005008), // primary
                                      size: 64,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(flex: 1),

                  // 3. Onboarding Promo/Offer Card (Animated)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _cardFadeAnimation.value,
                        child: FractionalTranslation(
                          translation: _cardSlideAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 380),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F6E9), // surface-container-low
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFBFCAB8), // outline-variant
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF181D16).withOpacity(0.04), // soft ambient shadow
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon Container
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFF005008), // primary
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.local_library_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Content Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'EXCLUSIVE WELCOME OFFER',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    color: const Color(0xFF005008), // primary
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Get 20% OFF',
                                  style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF181D16), // on-surface
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'On your first order of herbal essentials',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                    color: const Color(0xFF40493C), // on-surface-variant
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // 4. Action Button & Footer (Animated)
                  FadeTransition(
                    opacity: _buttonFadeAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Interactive Button with Scale Animation on Press
                        GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              _buttonScale = 0.96;
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              _buttonScale = 1.0;
                            });
                            _navigateToHome();
                          },
                          onTapCancel: () {
                            setState(() {
                              _buttonScale = 1.0;
                            });
                          },
                          child: AnimatedScale(
                            scale: _buttonScale,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                            child: Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(maxWidth: 320),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF005008), // primary Brand Color
                                borderRadius: BorderRadius.circular(8), // 8px buttons radius
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF005008).withOpacity(0.2), // premium Brand Shadow
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Get Started',
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Affirmation text
                        Text(
                          'HOLISTIC WELLNESS',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3.5,
                            color: const Color(0xFF707A6B), // outline
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Background Dot Painter
class DotPatternPainter extends CustomPainter {
  final Color dotColor;
  final double spacing;
  final double dotRadius;

  DotPatternPainter({
    this.dotColor = const Color(0x1F005008), // Subtle 12% opacity of primary #005008
    this.spacing = 24.0,
    this.dotRadius = 1.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    // Drawing circles in a grid alignment matching CSS pattern
    for (double x = 2.0; x < size.width; x += spacing) {
      for (double y = 2.0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
