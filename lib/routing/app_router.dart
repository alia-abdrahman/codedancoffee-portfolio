import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../pages/case_study_page.dart';
import '../pages/home_page.dart';
import '../theme/app_colors.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/work/:slug',
      builder: (context, state) {
        final slug = state.pathParameters['slug'];
        final match = projects.where((p) => p.slug == slug);
        if (match.isEmpty) {
          return _NotFound(slug: slug ?? '');
        }
        return CaseStudyPage(project: match.first);
      },
    ),
  ],
);

class _NotFound extends StatelessWidget {
  final String slug;
  const _NotFound({required this.slug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Project not found',
                style: GoogleFonts.fraunces(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: espresso,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'No case study matches "/work/$slug".',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: cocoa,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.go('/'),
                style: FilledButton.styleFrom(
                  backgroundColor: espresso,
                  foregroundColor: cream,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Back home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
