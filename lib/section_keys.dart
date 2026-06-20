import 'package:flutter/material.dart';

// One GlobalKey per scrollable section.
final GlobalKey heroKey = GlobalKey();
final GlobalKey servicesKey = GlobalKey();
final GlobalKey portfolioKey = GlobalKey();
final GlobalKey processKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();

// Shared smooth-scroll helper. Used by the nav links and by the hero CTAs.
void scrollToSection(GlobalKey key) {
  final ctx = key.currentContext;
  if (ctx == null) return;
  Scrollable.ensureVisible(
    ctx,
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeInOutCubic,
    alignment: 0.0,
  );
}
