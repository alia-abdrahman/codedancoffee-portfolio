import 'package:flutter/material.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'codedancoffee',
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
