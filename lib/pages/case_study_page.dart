import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/models.dart';
import '../sections/footer.dart';
import '../sections/nav_bar.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive.dart';

class CaseStudyPage extends StatelessWidget {
  final Project project;

  const CaseStudyPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Scaffold(
      endDrawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const NavBar(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mobile ? 24 : 48,
                vertical: mobile ? 24 : 40,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _BackLink(),
                      SizedBox(height: mobile ? 24 : 32),
                      _Hero(project: project),
                      SizedBox(height: mobile ? 32 : 48),
                      _CoverBlock(project: project),
                      SizedBox(height: mobile ? 56 : 96),
                      _Overview(project: project),
                      SizedBox(height: mobile ? 48 : 72),
                      if (project.tech.isNotEmpty) ...[
                        _TechStack(tech: project.tech),
                        SizedBox(height: mobile ? 48 : 72),
                      ],
                      _Visuals(),
                      SizedBox(height: mobile ? 56 : 96),
                      _CtaStrip(),
                    ],
                  ),
                ),
              ),
            ),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _BackLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => context.go('/'),
      icon: const Icon(Icons.arrow_back, size: 16, color: espresso),
      label: Text(
        'Back to portfolio',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: espresso,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final Project project;
  const _Hero({required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow: year · role
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: foam,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: caramel),
          ),
          child: Text(
            '${project.year}  ·  ${project.role}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: cocoa,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(height: mobile ? 24 : 32),

        // Big project name
        Text(
          project.name,
          style: GoogleFonts.fraunces(
            fontSize: mobile ? 44 : 72,
            fontWeight: FontWeight.w600,
            height: 1.05,
            letterSpacing: mobile ? -1.0 : -1.8,
            color: espresso,
          ),
        ),
        const SizedBox(height: 20),

        // Description / tagline
        SizedBox(
          width: 720,
          child: Text(
            project.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: mobile ? 16 : 18,
              height: 1.55,
              color: cocoa,
            ),
          ),
        ),

        // CTAs: Visit live, App Store
        if (project.url != null || project.appStoreUrl != null) ...[
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (project.url != null) _VisitLiveButton(url: project.url!),
              if (project.appStoreUrl != null)
                _StoreBadge(
                  url: project.appStoreUrl!,
                  assetPath: 'assets/images/badges/app-store.svg',
                  isSvg: true,
                  semanticLabel: 'Download on the App Store',
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _VisitLiveButton extends StatelessWidget {
  final String url;
  const _VisitLiveButton({required this.url});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      icon: const Icon(Icons.arrow_outward, size: 16),
      label: const Text('Visit live'),
      style: OutlinedButton.styleFrom(
        foregroundColor: espresso,
        side: BorderSide(color: caramel),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _StoreBadge extends StatelessWidget {
  final String url;
  final String assetPath;
  final bool isSvg;
  final String semanticLabel;

  const _StoreBadge({
    required this.url,
    required this.assetPath,
    required this.isSvg,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    // 56 px tall — above Apple/Google's 40 px minimum, plays well next
    // to the Visit live button's stadium-shape padding.
    const height = 56.0;

    final image = isSvg
        ? SvgPicture.asset(assetPath, height: height, semanticsLabel: semanticLabel)
        : Image.asset(assetPath, height: height, semanticLabel: semanticLabel);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: image,
      ),
    );
  }
}

class _CoverBlock extends StatelessWidget {
  final Project project;
  const _CoverBlock({required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: double.infinity,
        height: mobile ? 280 : 460,
        color: project.coverColor,
        alignment: Alignment.center,
        child: Text(
          project.name[0],
          style: GoogleFonts.fraunces(
            fontSize: mobile ? 180 : 280,
            fontWeight: FontWeight.w700,
            color: espresso,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Project project;
  const _Overview({required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: GoogleFonts.fraunces(
            fontSize: mobile ? 28 : 36,
            fontWeight: FontWeight.w600,
            height: 1.1,
            letterSpacing: -0.5,
            color: espresso,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 720,
          child: Text(
            project.summary,
            style: GoogleFonts.plusJakartaSans(
              fontSize: mobile ? 15 : 17,
              height: 1.7,
              color: cocoa,
            ),
          ),
        ),
      ],
    );
  }
}

class _TechStack extends StatelessWidget {
  final List<String> tech;
  const _TechStack({required this.tech});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tech we used',
          style: GoogleFonts.fraunces(
            fontSize: mobile ? 28 : 36,
            fontWeight: FontWeight.w600,
            height: 1.1,
            letterSpacing: -0.5,
            color: espresso,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final t in tech)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: foam,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: caramel),
                ),
                child: Text(
                  t,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: espresso,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Visuals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final cols = mobile ? 1 : 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visuals',
          style: GoogleFonts.fraunces(
            fontSize: mobile ? 28 : 36,
            fontWeight: FontWeight.w600,
            height: 1.1,
            letterSpacing: -0.5,
            color: espresso,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final spacing = 20.0;
            final tileWidth =
                (constraints.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    width: tileWidth,
                    height: tileWidth * 0.62,
                    decoration: BoxDecoration(
                      color: foam,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: caramel.withValues(alpha: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'TODO: visual ${i + 1}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: cocoa.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CtaStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 28 : 48,
        vertical: mobile ? 36 : 56,
      ),
      decoration: BoxDecoration(
        color: espresso,
        borderRadius: BorderRadius.circular(28),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ctaText(mobile: true),
                const SizedBox(height: 20),
                _ctaButton(context),
              ],
            )
          : Row(
              children: [
                Expanded(child: _ctaText(mobile: false)),
                const SizedBox(width: 32),
                _ctaButton(context),
              ],
            ),
    );
  }

  Widget _ctaText({required bool mobile}) {
    return Text(
      'Have a similar project? Let\'s talk.',
      style: GoogleFonts.fraunces(
        fontSize: mobile ? 24 : 32,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: -0.4,
        color: cream,
      ),
    );
  }

  Widget _ctaButton(BuildContext context) {
    return FilledButton(
      onPressed: () => context.go('/'),
      style: FilledButton.styleFrom(
        backgroundColor: cream,
        foregroundColor: espresso,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      child: const Text('Start a project'),
    );
  }
}
