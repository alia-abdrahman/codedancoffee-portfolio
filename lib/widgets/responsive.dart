import 'package:flutter/material.dart';

class Breakpoints {
  static const mobile = 768.0;
  static const tablet = 1100.0;
}

bool isMobile(BuildContext context) =>
    MediaQuery.sizeOf(context).width < Breakpoints.mobile;

bool isTablet(BuildContext context) =>
    MediaQuery.sizeOf(context).width < Breakpoints.tablet;

/// Picks a card width that gives 1 column on mobile, 2 columns on tablet,
/// and a fixed max on wide desktop.
double cardWidth(BuildContext context, {double max = 480}) {
  final w = MediaQuery.sizeOf(context).width;
  if (w < Breakpoints.mobile) return w - 80; // single column, account for outer padding
  if (w < Breakpoints.tablet) return (w - 116) / 2; // 2 columns
  return max;
}
