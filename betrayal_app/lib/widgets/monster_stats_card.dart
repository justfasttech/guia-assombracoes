import 'package:flutter/material.dart';
import '../models/monster.dart';
import '../theme/app_colors.dart';
import 'formatted_text.dart';

class MonsterStatsCard extends StatelessWidget {
  final Monster monster;

  const MonsterStatsCard({super.key, required this.monster});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pest_control, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  monster.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.accent,
                      ),
                ),
              ),
            ],
          ),
          if (_hasStats) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                if (monster.strength != null)
                  _StatChip(label: 'Força', value: monster.strength!, color: const Color(0xFFEF5350)),
                if (monster.speed != null)
                  _StatChip(label: 'Velocidade', value: monster.speed!, color: const Color(0xFF42A5F5)),
                if (monster.sanity != null)
                  _StatChip(label: 'Sanidade', value: monster.sanity!, color: const Color(0xFF66BB6A)),
                if (monster.knowledge != null)
                  _StatChip(label: 'Conhecimento', value: monster.knowledge!, color: const Color(0xFFFFCA28)),
              ],
            ),
          ],
          if (monster.description != null) ...[
            const SizedBox(height: 12),
            FormattedText(
              text: monster.description!,
              baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
            ),
          ],
          if (monster.actions.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: 12),
            Text(
              'Habilidades do Monstro (uma vez no turno)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.accent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...monster.actions.map((action) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        action.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      FormattedText(
                        text: action.description,
                        baseStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }

  bool get _hasStats =>
      monster.strength != null ||
      monster.speed != null ||
      monster.sanity != null ||
      monster.knowledge != null;
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 11,
                  color: color.withValues(alpha: 0.8),
                ),
          ),
        ],
      ),
    );
  }
}
