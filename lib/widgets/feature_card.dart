import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderGlass),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowSoft,
              blurRadius: _hovering ? 26 : 14,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(widget.icon, color: AppColors.chocolate, size: 22),
            ),
            const SizedBox(height: 16),
            Text(widget.title,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.darkText)),
            const SizedBox(height: 8),
            Text(widget.description,
                style: const TextStyle(fontSize: 13.5, color: AppColors.mutedText, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
