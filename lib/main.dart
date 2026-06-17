import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'sections/nav_bar.dart';
import 'sections/hero.dart';
import 'sections/services.dart';
import 'sections/portfolio.dart';
import 'sections/stats.dart';
import 'sections/process.dart';
import 'sections/contact.dart';
import 'sections/footer.dart';
import 'section_keys.dart';
void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'codedancoffee',
      theme: buildAppTheme(),
      home: Scaffold(
        endDrawer: const NavDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const NavBar(),
              HeroSection(key: heroKey),
              ServicesSection(key: servicesKey),
              PortfolioSection(key: portfolioKey),
              const StatsSection(),
              ProcessSection(key: processKey),
              ContactSection(key: contactKey),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
