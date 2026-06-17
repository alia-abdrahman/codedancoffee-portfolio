import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../data/models.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive.dart';

// Card palette cycles through these in order
const _cardColors = [latte, matcha, caramel, peach, vanilla];

// One icon per service, matching the order in content.dart
const _cardIcons = [
  Icons.language,                    // Website
  Icons.dashboard_customize_outlined, // Custom System
  Icons.phone_iphone,                // Mobile Application
  Icons.smart_toy_outlined,          // Web Automation
  Icons.fact_check_outlined,         // QA Testing
];

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final w = cardWidth(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 24 : 48,
        vertical: mobile ? 64 : 96,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Eyebrow pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: foam,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: caramel),
            ),
            child: Text(
              '✦  OUR SERVICES',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: cocoa,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section heading
          SizedBox(
            width: 720,
            child: Text(
              'Services tailored to ship things that actually run in production.',
              textAlign: TextAlign.center,
              style: GoogleFonts.fraunces(
                fontSize: mobile ? 28 : 40,
                fontWeight: FontWeight.w600,
                height: 1.15,
                letterSpacing: -0.8,
                color: espresso,
              ),
            ),
          ),
          SizedBox(height: mobile ? 40 : 56),

          // 2-column grid of service cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < services.length; i++)
                _ServiceCard(
                  service: services[i],
                  color: _cardColors[i % _cardColors.length],
                  icon: _cardIcons[i % _cardIcons.length],
                  width: w,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Service service;
  final Color color;
  final IconData icon;
  final double width;

  const _ServiceCard({
    required this.service,
    required this.color,
    required this.icon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon circle
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: foam,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: espresso, size: 26),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            service.title,
            style: GoogleFonts.fraunces(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: espresso,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            service.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              height: 1.55,
              color: cocoa,
            ),
          ),
        ],
      ),
    );
  }
}
