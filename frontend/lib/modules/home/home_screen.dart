import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../patient/patient_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Favorite trackers
  final Set<int> _favoriteProducts = {};

  // Shopping Cart items count
  int _cartCount = 3;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFavorite(int index) {
    setState(() {
      if (_favoriteProducts.contains(index)) {
        _favoriteProducts.remove(index);
      } else {
        _favoriteProducts.add(index);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _favoriteProducts.contains(index)
              ? 'Added to favorites!'
              : 'Removed from favorites',
          style: GoogleFonts.inter(),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addToCart() {
    setState(() {
      _cartCount += 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added to Cart!',
          style: GoogleFonts.inter(),
        ),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _cartCount -= 1;
            });
          },
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Curved Gradient Header & Search Bar
            if (_currentTabIndex != 4) _buildHeader(),

            // 2. Main content pages
            Expanded(
              child: _buildPageBody(),
            ),
          ],
        ),
      ),
      // Floating FAB
      floatingActionButton: _currentTabIndex == 0 ? _buildFloatingFAB() : null,
      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // --- HEADER WIDGET ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        gradient: LinearGradient(
          colors: [AppColors.primaryContainer, AppColors.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 24),
      child: Column(
        children: [
          // Row 1: Profile & Portal branding
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Menu Burger Button
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Menu clicked')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HOLISTIC PORTAL',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        'LifeHerba',
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  // Cart shopping badge button
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined,
                              color: Colors.white, size: 20),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Cart contains $_cartCount remedies!')),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color:
                                Color(0xFFF47779), // Warning Accent Red/Orange
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Center(
                            child: Text(
                              '$_cartCount',
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // User Profile circular avatar image
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondaryContainer,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://media.licdn.com/dms/image/v2/D5603AQF1KscyhgoRhw/profile-displayphoto-shrink_800_800/B56ZTxOOd.GoAc-/0/1739213827214?e=1781136000&v=beta&t=AeXJ3EBaiGUwkKeweQXjb7CPypJqrebit4My932bgVQ',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Row 2: Search input bar
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for Herbal Remedies...',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.primary,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.mic_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Voice search active...')),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- BODY SWITCHER ---
  Widget _buildPageBody() {
    switch (_currentTabIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildPlaceholderTab('Catalog', Icons.grid_view_rounded);
      case 2:
        return _buildPlaceholderTab(
            'Practitioners & Consultations', Icons.healing_rounded);
      case 3:
        return _buildPlaceholderTab(
            'Exclusive Deals & Offers', Icons.local_offer_rounded);
      case 4:
        return PatientProfileScreen(
          onMedsOrdered: _addToCart,
        );
      default:
        return _buildHomeTab();
    }
  }

  // --- TAB 1: HOME TAB DASHBOARD CONTENT ---
  Widget _buildHomeTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20, bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Swipable Promo Banners Carousel
          _buildBannersCarousel(),
          const SizedBox(height: 28),

          // 2. Categories Grid Selection
          _buildCategoriesGrid(),
          const SizedBox(height: 28),

          // 3. Specialist AYUSH Consultation Banner
          _buildConsultationBanner(),
          const SizedBox(height: 28),

          // 4. Trending Remedies List
          _buildTrendingRemedies(),
          const SizedBox(height: 28),

          // 5. Partner federation mission statement
          _buildMissionStatement(),
          const SizedBox(height: 28),

          // 6. Community stories testimonies
          _buildCommunityStories(),
        ],
      ),
    );
  }

  // --- PLACEHOLDER BODY TAB ---
  Widget _buildPlaceholderTab(String title, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 72,
              color: AppColors.primary.withOpacity(0.15),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'This module contains full business controls and catalog data, configured and ready for connection.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // --- SUBWIDGET: BANNER CAROUSEL ---
  Widget _buildBannersCarousel() {
    final size = MediaQuery.of(context).size;
    final bannerWidth = size.width * 0.88;

    final List<Map<String, String>> banners = [
      {
        'title': 'Traditional Wisdom',
        'sub': 'Modern Care for holistic well-being.',
        'btn': 'Explore Now',
        'img':
            'https://retention-images.pharmeasy.in/store_assets/tile/branded_09092025.png?dim=128x128&q=75',
        'icon': 'arrow_forward',
      },
      {
        'title': 'Expert Consultations',
        'sub': 'Connect with certified practitioners.',
        'btn': 'Book Now',
        'img':
            'https://lh3.googleusercontent.com/aida/ADBb0ugOG1Y83VXZDnTuCDrvG64aZtU274QPSgHMKleMwcoVDDn39PJRoM9tvoqsiy7w8Zl73tuGWvMF4Y1EUEstSmWzmitIn9TvnXK1X6w3lGu9uGi-h7HlWgEkutoH8sFEbch4_w845zoHHC3RJATCtdFSZckvsgV-IXhD89tAYQr5ovKZUByHZm5UP1a7MORKh1Aat4qBlsJP8so7BIAB5IMWFCSNLZlZghCvoaeYtBt6hdOcFikFx2Y9Aek',
        'icon': 'event_available',
      },
      {
        'title': 'Immunity Boosters',
        'sub': 'Up to 30% off on supplements.',
        'btn': 'Shop Now',
        'img':
            'https://lh3.googleusercontent.com/aida/ADBb0uileAjUdJPm7XovCTLEtu7tswoPMjls1zoh0uJ0qQt0ALAGeWdiueNL2Guqc8zjlkPLZ7Me5CGU20H3Up-c-5SjJ_dS34G2VnG1f31PeeCa_ZnCaFqJJXXHh0NnzFPdmOcXlUozeNExj5pTnQQ8Kzdn3mccat-jR1wrhe5NsfZmoc-qIowGB7RWx_Y8FXlAZr8U8uCfk9EeSL1-Au_qlEiw8EFLayC4Hz-t7AtHSjgshpagDX1g-91-3RQ',
        'icon': 'shopping_bag',
      }
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(), // provides snapping effect
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: banners.map((b) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: bannerWidth,
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Banner Image
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.network(
                          b['img']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.surfaceContainerHigh,
                          ),
                        ),
                      ),
                    ),
                    // Light Overlay for text readability
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.95),
                              Colors.white.withOpacity(0.4),
                              Colors.transparent,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                    // Banner Content Text
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            b['title']!,
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: bannerWidth * 0.65,
                            child: Text(
                              b['sub']!,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurfaceVariant,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Button Action
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Campaign: ${b['title']}')),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    b['btn']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    b['icon'] == 'event_available'
                                        ? Icons.event_available_rounded
                                        : b['icon'] == 'shopping_bag'
                                            ? Icons.shopping_bag_outlined
                                            : Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- SUBWIDGET: CATEGORIES GRID ---
  Widget _buildCategoriesGrid() {
    final List<Map<String, dynamic>> cats = [
      {'name': 'Ayurveda', 'icon': Icons.spa_outlined},
      {'name': 'Unani', 'icon': Icons.favorite_outline_rounded},
      {'name': 'Homeo', 'icon': Icons.water_drop_outlined},
      {'name': 'Supps', 'icon': Icons.spa_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore Categories',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Full Catalog active')),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'View all',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: cats.map((c) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Selected Category: ${c['name']}')),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: AppColors.outlineVariant.withOpacity(0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            c['icon'] as IconData,
                            color: AppColors.primary,
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        c['name'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --- SUBWIDGET: CONSULTATION BANNER ---
  Widget _buildConsultationBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.tertiaryContainer, // Deep organic orange #BD5700
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.tertiaryContainer.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // Decorative background overlays
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Consult a Specialist',
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Talk to certified AYUSH practitioners instantly from anywhere.',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.85),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Book CTA button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.tertiary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _currentTabIndex =
                                  2; // Jump cleanly to Consult Tab!
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Book Now',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.event_available_rounded,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Doctor Caricature Image card
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAu0ExnUtNyCURhDr_6C305C7SzaWJyzD4ZiiY-FhFVtChOKbK9eBXoVxMbTz9FzYuxO3CRM0VzmsrMvMwYVM66rp4vjeVHcGWhCXijFTdDFeGmuQF_tdUHbHSbfrjChPgfqS6jtEn96RqV2hJsq1p-cu06oSM5XmpW1RJOMDSfRF3t0kwlRTQOed_AoswA-uuYsAnV4HSRFUGt3BnkquoliInt1f5n9dvPHkp5g5gpcnMObZ2WBCBvzH9XWypY-EjtJ4r14B85hNQ',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.medical_services_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- SUBWIDGET: TRENDING REMEDIES ---
  Widget _buildTrendingRemedies() {
    final List<Map<String, dynamic>> products = [
      {
        'id': 1,
        'title': 'Organic Ashwagandha',
        'price': '₹499',
        'old': '₹650',
        'bestseller': true,
        'img':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCD1ZXjFfyT5Zhmq5Sw_iLlUMT7rdfLEtAaDoztZDNx15M76saWZ8ZgKq6Esii1BKKTEAXWMr2jHmPwdZidMC2Aqv0I6b3Hc-BHsbaEK4x6FWY5BrZl_iGK7E3t4-r9x_Y0jyofyP42iT0azS0hXm56R4DMlGHGaqjbk4A9i36qhMMQa7k6g8M14ZHPrEpMeqsBJiebhPTAYAmOGmailWhHXAyPT9ixDdmKwmgXHQo6O7hJl7bg-J8nIPGScPBtbYfh0tVj5EMnsxE',
      },
      {
        'id': 2,
        'title': 'Pure Curcumin',
        'price': '₹325',
        'old': '₹450',
        'bestseller': false,
        'img':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBLnW2wHxymC2_9-cZp2msOjM509Ca-ejt5FIEMc7_X1kf3Wfsk9BKPDU-366NleMTCbcqW1WvSY-f1xrQCOusGlHPuiQyruBAa0CxquFSvyE0Rq12UentCLjhfihL1iU8045opUnCETPEGd5JbdjBuYoeupZ1xQ14cY9b4J3sSldAb1ZmZbINr5ThJ7BwHPUMzOa7MtV9zZ7LB-Q0fNvevzRV3UBL7YCt1dlYHnyaDsUn6h_GhZpqdEleH6zeU_uRNiKTIdLhidiY',
      }
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Remedies',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentTabIndex = 1; // Go to Catalog!
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: products.map((p) {
              final isFav = _favoriteProducts.contains(p['id']);
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.outlineVariant.withOpacity(0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image frame
                      Stack(
                        children: [
                          Container(
                            height: 160,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.network(
                                p['img']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: Icon(Icons.spa_rounded,
                                      color: AppColors.primary),
                                ),
                              ),
                            ),
                          ),
                          // Bestseller tag
                          if (p['bestseller'])
                            Positioned(
                              top: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF47779),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'BESTSELLER',
                                  style: GoogleFonts.inter(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          // Fav button
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: isFav ? Colors.red : AppColors.primary,
                                  size: 18,
                                ),
                                onPressed: () =>
                                    _toggleFavorite(p['id'] as int),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Text Contents
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p['title']!,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  p['price']!,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  p['old']!,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppColors.outline,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Add button
                            SizedBox(
                              width: double.infinity,
                              height: 38,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _addToCart,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_shopping_cart_rounded,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Add to Cart',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // --- SUBWIDGET: MISSION STATEMENT ---
  Widget _buildMissionStatement() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.outlineVariant.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.format_quote_rounded,
              color: AppColors.primary.withOpacity(0.2),
              size: 48,
            ),
            Text(
              '“Empowering traditional medicines for holistic well-being, fostering global collaboration.”',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 1,
              color: AppColors.outlineVariant.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Mini emblem holder
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.verified_user_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Federation of Holistic Health',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: AppColors.primary,
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'OFFICIAL PARTNER',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: AppColors.outline,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- SUBWIDGET: COMMUNITY STORIES ---
  Widget _buildCommunityStories() {
    final List<Map<String, String>> stories = [
      {
        'name': 'Sarah L.',
        'text':
            '"After years of dealing with chronic pain, I finally found relief through holistic treatments here. Life-changing experience!"',
        'img':
            'https://media.licdn.com/dms/image/v2/D5603AQF1KscyhgoRhw/profile-displayphoto-shrink_800_800/B56ZTxOOd.GoAc-/0/1739213827214?e=1781136000&v=beta&t=AeXJ3EBaiGUwkKeweQXjb7CPypJqrebit4My932bgVQ',
      },
      {
        'name': 'Mahesh T.',
        'text':
            '"The combination of traditional wisdom and modern practices offered a unique path to wellness I couldn\'t find anywhere else."',
        'img':
            'https://media.licdn.com/dms/image/v2/D5603AQF1KscyhgoRhw/profile-displayphoto-shrink_800_800/B56ZTxOOd.GoAc-/0/1739213827214?e=1781136000&v=beta&t=AeXJ3EBaiGUwkKeweQXjb7CPypJqrebit4My932bgVQ',
      }
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Community Stories',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: stories.map((s) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.outlineVariant.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    s['img']!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.person_rounded,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.verified_rounded,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s['name']!,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // 5 gold stars
                              Row(
                                children: List.generate(5, (index) {
                                  return const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFFFB800),
                                    size: 16,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        s['text']!,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: AppColors.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // --- FLOATING ACTION BUTTON ---
  Widget _buildFloatingFAB() {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Launching Instant AYUSH Quick Care...')),
            );
          },
          child: const Center(
            child: Icon(
              Icons.medical_services_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  // --- BOTTOM NAVIGATION BAR ---
  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 20, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, 'Home', Icons.home_rounded, Icons.home_outlined),
          _buildNavItem(
              1, 'Catalog', Icons.grid_view_rounded, Icons.grid_view_rounded),
          _buildCustomNavItem(2, 'Consult',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCw_CDEir-r7A7ObvwAYWIvgBrGy2MgFWnPNQuRSxKCDC_8tPLJJp0p2VfFAkEfCeHJw7tYt5qxrZbFTwsc0-at2pwmBjrDahzMbPd1ye3pocakbObW7f4J3i2g_cdaYlEIY0UiqB4ejy0GuaD5rbb1ztUjH_ujnoDx4pMSkEr_9BN6nc4Rz_0ClU-Q7_VTf__eGQ5gQgZs0wvXbXl3c5HhKsksWKQH_1kNOgv0y3He-aJtbsNnue05fnU-JVfoX2kKyXgaZ6BrSRw'),
          _buildNavItem(3, 'Deals', Icons.local_offer_rounded,
              Icons.local_offer_outlined),
          _buildNavItem(
              4, 'Profile', Icons.person_rounded, Icons.person_outline_rounded),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      int index, String label, IconData filledIcon, IconData outlineIcon) {
    final isActive = _currentTabIndex == index;
    final color = isActive
        ? AppColors.primary
        : AppColors.onSurfaceVariant.withOpacity(0.6);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentTabIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 38,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                isActive ? filledIcon : outlineIcon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomNavItem(int index, String label, String imgUrl) {
    final isActive = _currentTabIndex == index;
    final color = isActive
        ? AppColors.primary
        : AppColors.onSurfaceVariant.withOpacity(0.6);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentTabIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 38,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(6),
              child: Image.network(
                imgUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.healing_rounded,
                  color: color,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
