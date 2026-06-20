import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../data/models.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

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
              '✦  OUR WORK',
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
              'Recent things we shipped for founders and teams.',
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

          // Project grid
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              for (final p in projects)
                _ProjectCard(project: p, width: w),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final double width;

  const _ProjectCard({
    required this.project,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: foam,
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.go('/work/${project.slug}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Placeholder image area — swap for a real screenshot later
              Container(
                height: 240,
                color: project.coverColor,
                child: Center(
                  child: Text(
                    project.name[0],
                    style: GoogleFonts.fraunces(
                      fontSize: 96,
                      fontWeight: FontWeight.w700,
                      color: espresso,
                      height: 1.0,
                    ),
                  ),
                ),
              ),

              // Text content
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      project.name,
                      style: GoogleFonts.fraunces(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: espresso,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      project.description,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        height: 1.55,
                        color: cocoa,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // "View case study" link
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View case study',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: espresso,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_outward,
                            size: 16, color: espresso),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
