import 'package:flutter/material.dart';
import '../models/haunt_category.dart';
import '../theme/app_colors.dart';

class CategoryHeader extends StatelessWidget {
  final HauntCategory category;
  final int count;

  const CategoryHeader({
    super.key,
    required this.category,
    required this.count,
  });

  Color get _accentColor {
    return switch (category) {
      HauntCategory.revelacaoClassica => AppColors.primary,
      HauntCategory.semTraidor => AppColors.success,
      HauntCategory.traidorOculto => AppColors.purple,
      HauntCategory.todosContraTodos => AppColors.orange,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: _accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category.displayName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _accentColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
