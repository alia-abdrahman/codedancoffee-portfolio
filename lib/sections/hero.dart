import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        mobile ? 24 : 48,
        mobile ? 32 : 64,
        mobile ? 24 : 48,
        mobile ? 56 : 96,
      ),
      child: mobile
          ? const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroText(),
                SizedBox(height: 32),
                _HeroArch(height: 280),
              ],
            )
          : const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _HeroText()),
                SizedBox(width: 48),
                Expanded(child: _HeroArch(height: 480)),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // * HELLO pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: foam,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: caramel),
          ),
          child: Text(
            '✦  HELLO',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: cocoa,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: mobile ? 24 : 32),

        // Headline — no forced breaks; lets wrap fluidly
        Text(
          'We design, build, and ship software that moves fast, without breaking things.',
          style: GoogleFonts.fraunces(
            fontSize: mobile ? 36 : 56,
            fontWeight: FontWeight.w600,
            height: mobile ? 1.1 : 1.05,
            letterSpacing: mobile ? -1.0 : -1.5,
            color: espresso,
          ),
        ),
        const SizedBox(height: 24),

        // Tagline
        Text(
          companyTagline,
          style: GoogleFonts.plusJakartaSans(
            fontSize: mobile ? 16 : 18,
            height: 1.5,
            color: cocoa,
          ),
        ),
        const SizedBox(height: 40),

        // CTAs
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: espresso,
                foregroundColor: cream,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              child: const Text('Start a project'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: espresso,
                side: BorderSide(color: caramel),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              child: const Text('See our work'),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroArch extends StatelessWidget {
  final double height;
  const _HeroArch({required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(300),
      ),
      child: Container(
        height: height,
        color: latte,
        child: const Center(
          child: Icon(
            Icons.coffee_outlined,
            size: 140,
            color: espresso,
          ),
        ),
      ),
    );
  }
}
