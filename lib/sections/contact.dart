import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/content.dart';
import '../theme/app_colors.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 24, 48, 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 96),
        decoration: BoxDecoration(
          color: espresso,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            // Eyebrow pill (inverted for dark bg)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: espresso,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: cocoa),
              ),
              child: Text(
                "✦  LET'S TALK",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: cream,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Big heading
            SizedBox(
              width: 720,
              child: Text(
                "Got an idea brewing?\nLet's ship it together.",
                textAlign: TextAlign.center,
                style: GoogleFonts.fraunces(
                  fontSize: 56,
                  fontWeight: FontWeight.w600,
                  height: 1.05,
                  letterSpacing: -1.5,
                  color: cream,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Body
            SizedBox(
              width: 560,
              child: Text(
                "Tell us a bit about what you're building. We reply within a working day.",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                  height: 1.5,
                  color: latte,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // CTA — real mailto button
            FilledButton(
              onPressed: () async {
                final uri = Uri.parse('mailto:$companyEmail');
                await launchUrl(uri);
              },
              style: FilledButton.styleFrom(
                backgroundColor: cream,
                foregroundColor: espresso,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 22,
                ),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(companyEmail),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_outward, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
