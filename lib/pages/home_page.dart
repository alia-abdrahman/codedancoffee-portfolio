import 'package:flutter/material.dart';
import '../section_keys.dart';
import '../sections/contact.dart';
import '../sections/footer.dart';
import '../sections/hero.dart';
import '../sections/nav_bar.dart';
import '../sections/portfolio.dart';
import '../sections/process.dart';
import '../sections/services.dart';
import '../sections/stats.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
