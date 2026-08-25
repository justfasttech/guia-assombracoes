import 'package:flutter/material.dart';
import '../models/haunt.dart';
import '../theme/app_colors.dart';
import 'haunt_type_badge.dart';

class HauntListItem extends StatelessWidget {
  final Haunt haunt;
  final VoidCallback onTap;

  const HauntListItem({
    super.key,
    required this.haunt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  haunt.number.toString().padLeft(2, '0'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      haunt.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    HauntTypeBadge(
                      traitorType: haunt.traitorType,
                      category: haunt.category,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
