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
        child: const Center(child: _HeroCode()),
      ),
    );
  }
}

class _HeroCode extends StatelessWidget {
  const _HeroCode();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final scale = (h / 480).clamp(0.5, 1.0);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. Concentric arcs (bottom-left, partly clipped by arch)
            Positioned(
              left: -w * 0.05,
              bottom: -h * 0.05,
              child: CustomPaint(
                size: Size(w * 0.95, h * 0.7),
                painter: _ArcsPainter(),
              ),
            ),

            // 2. Caramel rounded wedge (middle-right)
            Positioned(
              right: w * 0.15,
              top: h * 0.30,
              child: Container(
                width: 140 * scale,
                height: 140 * scale,
                decoration: BoxDecoration(
                  color: caramel,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(140 * scale),
                  ),
                ),
              ),
            ),

            // 3. Small dark espresso circle (top-left of composition)
            Positioned(
              left: w * 0.18,
              top: h * 0.22,
              child: Container(
                width: 56 * scale,
                height: 56 * scale,
                decoration: const BoxDecoration(
                  color: espresso,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 4. Dot grid (center)
            Positioned(
              left: w * 0.28,
              top: h * 0.46,
              child: _DotGrid(
                rows: 5,
                cols: 6,
                dotSize: 4 * scale,
                spacing: 12 * scale,
              ),
            ),

            // 5. Large dark espresso circle (bottom-right, clipped by arch)
            Positioned(
              right: -w * 0.1,
              bottom: -h * 0.15,
              child: Container(
                width: 220 * scale,
                height: 220 * scale,
                decoration: const BoxDecoration(
                  color: espresso,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DotGrid extends StatelessWidget {
  final int rows;
  final int cols;
  final double dotSize;
  final double spacing;
  const _DotGrid({
    required this.rows,
    required this.cols,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int r = 0; r < rows; r++)
          Padding(
            padding: EdgeInsets.only(top: r == 0 ? 0 : spacing),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int c = 0; c < cols; c++)
                  Padding(
                    padding: EdgeInsets.only(left: c == 0 ? 0 : spacing),
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        color: cocoa.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ArcsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cocoa.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Origin of the ripples sits low-left and slightly outside.
    final center = Offset(size.width * 0.25, size.height + 20);
    for (int i = 0; i < 10; i++) {
      final radius = 70.0 + i * 28.0;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
