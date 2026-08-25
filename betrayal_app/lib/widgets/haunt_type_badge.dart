import 'package:flutter/material.dart';
import '../models/haunt_category.dart';
import '../theme/app_colors.dart';

class HauntTypeBadge extends StatelessWidget {
  final String traitorType;
  final HauntCategory? category;

  const HauntTypeBadge({
    super.key,
    required this.traitorType,
    this.category,
  });

  Color get _backgroundColor {
    return switch (category) {
      HauntCategory.semTraidor => AppColors.success.withValues(alpha: 0.2),
      HauntCategory.traidorOculto => AppColors.purple.withValues(alpha: 0.2),
      HauntCategory.todosContraTodos => AppColors.orange.withValues(alpha: 0.2),
      _ => AppColors.primary.withValues(alpha: 0.2),
    };
  }

  Color get _textColor {
    return switch (category) {
      HauntCategory.semTraidor => const Color(0xFF66BB6A),
      HauntCategory.traidorOculto => const Color(0xFFAB47BC),
      HauntCategory.todosContraTodos => const Color(0xFFFF7043),
      _ => AppColors.primaryLight,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        traitorType,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              color: _textColor,
              fontWeight: FontWeight.w500,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
