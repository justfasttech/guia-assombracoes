import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RoleCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.diagonal3Values(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0, 1.0),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface,
                _isHovered ? AppColors.secondary.withValues(alpha: 0.3) : AppColors.surface,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.divider,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 48,
                color: _isHovered ? AppColors.accent : AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Entrar',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
