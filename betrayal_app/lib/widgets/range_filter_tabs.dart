import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RangeFilterTabs extends StatelessWidget {
  final int? selectedRange;
  final ValueChanged<int?> onRangeSelected;

  const RangeFilterTabs({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  static const _ranges = [
    (1, 10),
    (11, 20),
    (21, 30),
    (31, 40),
    (41, 50),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _ranges.map((range) {
          final isSelected = selectedRange == range.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text('${range.$1}-${range.$2}'),
              selected: isSelected,
              onSelected: (_) {
                onRangeSelected(isSelected ? null : range.$1);
              },
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.divider,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
