import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

// A list of records — each is an anonymous bundle with `value` and `label` fields.
// Edit these freely to fit reality.
const _stats = <({String value, String label})>[
  (value: '7+', label: 'Projects shipped'),
  (value: '5', label: 'Core services'),
  (value: '4+', label: 'Years building'),
  (value: '100%', label: 'Freshly brewed'),
];

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 8, 48, 96),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
        decoration: BoxDecoration(
          color: foam,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: caramel),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final stat in _stats)
              _StatTile(value: stat.value, label: stat.label),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String value;
  final String label;

  const _StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: GoogleFonts.fraunces(
            fontSize: 56,
            fontWeight: FontWeight.w600,
            color: espresso,
            height: 1.0,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: cocoa,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
