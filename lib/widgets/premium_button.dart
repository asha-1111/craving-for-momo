import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

enum PremiumButtonStyle { primary, secondary }

/// Reusable premium pill-shaped button with hover scale + shadow animation.
class PremiumButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final PremiumButtonStyle style;
  final double? width;
  final double height;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.style = PremiumButtonStyle.primary,
    this.width,
    this.height = 52,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.style == PremiumButtonStyle.primary;

    final Color bgColor = isPrimary ? AppColors.white : Colors.transparent;
    final Color textColor = isPrimary ? AppColors.chocolate : AppColors.darkText;
    final Border? border = isPrimary
        ? Border.all(color: AppColors.pastelPeach, width: 1.2)
        : Border.all(color: AppColors.chocolate.withOpacity(0.35), width: 1.2);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _hovering ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 26),
            decoration: BoxDecoration(
              color: bgColor,
              gradient: isPrimary ? null : null,
              borderRadius: BorderRadius.circular(999),
              border: border,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowSoft,
                  blurRadius: _hovering ? 22 : 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 8),
                  AnimatedSlide(
                    offset: _hovering ? const Offset(0.15, 0) : Offset.zero,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(widget.icon, size: 18, color: textColor),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
