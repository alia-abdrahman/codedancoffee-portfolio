import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive.dart';

// Step records — tweak the wording to match how you actually work
const _steps = <({String number, String title, String description, IconData icon})>[
  (
    number: '01',
    title: 'Discovery',
    description:
        'We listen, ask hard questions, and define what success looks like before we touch code.',
    icon: Icons.lightbulb_outline,
  ),
  (
    number: '02',
    title: 'Design',
    description:
        'Mockups, flows, and architecture decisions you can review before we build.',
    icon: Icons.architecture_outlined,
  ),
  (
    number: '03',
    title: 'Build',
    description:
        'Short cycles, weekly checkpoints, no surprises at the end. Progress in real time.',
    icon: Icons.code,
  ),
  (
    number: '04',
    title: 'Ship',
    description:
        'Deploy, monitor, hand off. We make sure what we built keeps working after we leave.',
    icon: Icons.rocket_launch_outlined,
  ),
];

const _stepColors = [peach, vanilla, matcha, caramel];

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final w = cardWidth(context, max: 280);
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
              '✦  OUR PROCESS',
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
              'From first chat to live in production.',
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

          // 4 step cards
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < _steps.length; i++)
                _ProcessCard(
                  number: _steps[i].number,
                  title: _steps[i].title,
                  description: _steps[i].description,
                  icon: _steps[i].icon,
                  color: _stepColors[i % _stepColors.length],
                  width: w,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProcessCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final double width;

  const _ProcessCard({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row: number + icon circle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                number,
                style: GoogleFonts.fraunces(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: espresso,
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: foam,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: espresso, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Title
          Text(
            title,
            style: GoogleFonts.fraunces(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: espresso,
            ),
          ),
          const SizedBox(height: 10),

          // Description
          Text(
            description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              height: 1.55,
              color: cocoa,
            ),
          ),
        ],
      ),
    );
  }
}
