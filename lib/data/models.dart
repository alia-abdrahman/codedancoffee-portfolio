import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Service {
  final String title;
  final String description;

  const Service({
    required this.title,
    required this.description,
  });
}

class Project {
  final String name;
  final String slug;
  final String description;
  final String summary;
  final String year;
  final String role;
  final Color coverColor;
  final List<String> tech;
  final String? url;
  final String? appStoreUrl;

  const Project({
    required this.name,
    required this.slug,
    required this.description,
    this.summary = 'TODO: write a 1–2 paragraph overview for this project.',
    this.year = 'TODO',
    this.role = 'Design + Build',
    this.coverColor = latte,
    this.tech = const [],
    this.url,
    this.appStoreUrl,
  });
}
