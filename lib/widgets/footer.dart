import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

class AppFooter extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onMenuTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;

  const AppFooter({
    super.key,
    required this.onHomeTap,
    required this.onMenuTap,
    required this.onAboutTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 40),
      decoration: const BoxDecoration(
        color: AppColors.darkText,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 24,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppConstants.businessName,
                      style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(AppConstants.tagline,
                      style: TextStyle(color: AppColors.white.withOpacity(0.7), fontSize: 13)),
                ],
              ),
              Row(
                children: [
                  _FooterLink(label: 'Home', onTap: onHomeTap),
                  _FooterLink(label: 'Menu', onTap: onMenuTap),
                  _FooterLink(label: 'About', onTap: onAboutTap),
                  _FooterLink(label: 'Contact', onTap: onContactTap),
                ],
              ),
              Row(
                children: [
                  _SocialIcon(icon: Icons.facebook_rounded),
                  const SizedBox(width: 10),
                  _SocialIcon(icon: Icons.camera_alt_outlined),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          Divider(color: AppColors.white.withOpacity(0.15)),
          const SizedBox(height: 16),
          Text(
            AppConstants.copyright,
            style: TextStyle(color: AppColors.white.withOpacity(0.55), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Text(label, style: TextStyle(color: AppColors.white.withOpacity(0.8), fontSize: 13.5)),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white.withOpacity(0.25)),
      ),
      child: Icon(icon, color: AppColors.white, size: 16),
    );
  }
}
