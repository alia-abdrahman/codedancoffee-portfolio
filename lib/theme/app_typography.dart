import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

// Display serif — Fraunces — for big editorial headings
final TextStyle displayLarge = GoogleFonts.fraunces(
  fontSize: 64,
  fontWeight: FontWeight.w600,
  height: 1.05,
  letterSpacing: -1.0,
  color: espresso,
);

final TextStyle displayMedium = GoogleFonts.fraunces(
  fontSize: 48,
  fontWeight: FontWeight.w600,
  height: 1.1,
  letterSpacing: -0.5,
  color: espresso,
);

final TextStyle displaySmall = GoogleFonts.fraunces(
  fontSize: 32,
  fontWeight: FontWeight.w600,
  height: 1.15,
  color: espresso,
);

// Body sans — Plus Jakarta Sans — for everything that isn't a heading
final TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  height: 1.5,
  color: cocoa,
);

final TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.5,
  color: cocoa,
);

// Small uppercase label — for badges and section eyebrows
final TextStyle labelLarge = GoogleFonts.plusJakartaSans(
  fontSize: 13,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.2,
  color: espresso,
);
