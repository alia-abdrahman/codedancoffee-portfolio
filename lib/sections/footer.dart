import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../theme/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 48, 48, 32),
      child: Row(
        children: [
          // Logo
          Text(
            companyName,
            style: GoogleFonts.fraunces(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: espresso,
              letterSpacing: -0.2,
            ),
          ),
          const Spacer(),

          // Copyright
          Text(
            '© 2026 $companyName · Brewed with care',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: cocoa,
            ),
          ),
          const Spacer(),

          // Socials
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mail_outline),
            color: cocoa,
            tooltip: 'Email',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.code),
            color: cocoa,
            tooltip: 'GitHub',
          ),
        ],
      ),
    );
  }
}
