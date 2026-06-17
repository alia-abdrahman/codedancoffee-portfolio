import 'package:flutter/material.dart';

// One GlobalKey per scrollable section.
// Both main.dart (where the section widgets live) and nav_bar.dart (where the
// nav links live) import this file and use the same keys.
final GlobalKey heroKey = GlobalKey();
final GlobalKey servicesKey = GlobalKey();
final GlobalKey portfolioKey = GlobalKey();
final GlobalKey processKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();
