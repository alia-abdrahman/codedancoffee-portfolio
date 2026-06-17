import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../section_keys.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive.dart';

// Helper: smooth-scroll to the section tagged with `key`.
void _scrollTo(GlobalKey key) {
  final ctx = key.currentContext;
  if (ctx == null) return;
  Scrollable.ensureVisible(
    ctx,
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeInOutCubic,
    alignment: 0.0,
  );
}

// One source of truth for the nav links so desktop bar + mobile drawer match.
final _navItems = <({String label, GlobalKey key})>[
  (label: 'Home', key: heroKey),
  (label: 'Services', key: servicesKey),
  (label: 'Portfolio', key: portfolioKey),
  (label: 'Process', key: processKey),
  (label: 'Contact', key: contactKey),
];

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 24 : 48,
        vertical: 24,
      ),
      child: Row(
        children: [
          // Logo
          Text(
            companyName,
            style: GoogleFonts.fraunces(
              fontSize: mobile ? 18 : 22,
              fontWeight: FontWeight.w700,
              color: espresso,
              letterSpacing: -0.3,
            ),
          ),

          const Spacer(),

          // Either inline nav OR hamburger
          if (mobile)
            IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.menu),
              color: espresso,
              tooltip: 'Menu',
            )
          else ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in _navItems) ...[
                  _NavLink(item.label, item.key),
                  const SizedBox(width: 4),
                ],
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mail_outline),
              color: espresso,
              tooltip: 'Email',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.code),
              color: espresso,
              tooltip: 'GitHub',
            ),
          ],
        ],
      ),
    );
  }
}

// Drawer shown on mobile when the hamburger is tapped.
class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: cream,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: GoogleFonts.fraunces(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: espresso,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 32),
              for (final item in _navItems)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: cocoa,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); // close drawer
                    _scrollTo(item.key);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final GlobalKey targetKey;
  const _NavLink(this.label, this.targetKey);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _scrollTo(targetKey),
      style: TextButton.styleFrom(
        foregroundColor: cocoa,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      child: Text(label),
    );
  }
}
