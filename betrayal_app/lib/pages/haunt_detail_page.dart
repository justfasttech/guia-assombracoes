import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/haunts_repository.dart';
import '../models/haunt.dart';
import '../models/haunt_category.dart';
import '../models/haunt_role.dart';
import '../data/tile_translations.dart';
import '../theme/app_colors.dart';
import '../widgets/formatted_text.dart';
import '../widgets/monster_stats_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_card.dart';

class HauntDetailPage extends StatefulWidget {
  final HauntRole role;
  final int hauntId;

  const HauntDetailPage({
    super.key,
    required this.role,
    required this.hauntId,
  });

  @override
  State<HauntDetailPage> createState() => _HauntDetailPageState();
}

class _HauntDetailPageState extends State<HauntDetailPage> {
  HauntRole get role => widget.role;
  int get hauntId => widget.hauntId;

  @override
  Widget build(BuildContext context) {
    final haunt = HauntsRepository.getHaunt(role, hauntId);

    if (haunt == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline,
                  size: 64, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              Text(
                'Assombração #$hauntId não encontrada',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => context.go('/${role.urlPath}'),
                child: const Text('Voltar à lista'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ResponsiveLayout(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNavigation(context),
                const SizedBox(height: 16),
                if (haunt.category != HauntCategory.revelacaoClassica)
                  _buildCategoryBanner(context, haunt),
                _buildHeader(context, haunt),
                _buildMetadata(context, haunt),
                if (haunt.introduction.isNotEmpty)
                  _buildIntroduction(context, haunt),
                if (haunt.setup.isNotEmpty) _buildSetup(context, haunt),
                if (haunt.objective != null)
                  _buildObjective(context, haunt),
                if (haunt.requiredMarkers != null)
                  _buildMarkers(context, haunt),
                if (haunt.requiredMarkers != null && _hasTiles(haunt))
                  _buildTiles(context, haunt),
                if (haunt.specialRules.isNotEmpty)
                  _buildSpecialRules(context, haunt),
                if (haunt.specialActions.isNotEmpty)
                  _buildSpecialActions(context, haunt),
                if (haunt.monsters.isNotEmpty)
                  _buildMonsters(context, haunt),
                if (haunt.conclusion != null &&
                    haunt.conclusion!.isNotEmpty)
                  _buildConclusion(context, haunt),
                if (haunt.defeatConclusion != null &&
                    haunt.defeatConclusion!.isNotEmpty)
                  _buildDefeatConclusion(context, haunt),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation(BuildContext context) {
    final isSurvivor = role == HauntRole.survivor;

    return Row(
      children: [
        TextButton.icon(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.home, size: 18),
          label: Text(''),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: () => context.go('/${role.urlPath}'),
          icon: const Icon(Icons.list, size: 18),
          label: const Text('List'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () => context.push('/eventos'),
          icon: const Icon(Icons.auto_stories, size: 20),
          tooltip: 'Eventos',
          color: const Color(0xFFD4A017),
          visualDensity: VisualDensity.compact,
        ),
        IconButton(
          onPressed: () => context.push('/cartas'),
          icon: const Icon(Icons.inventory_2, size: 20),
          tooltip: 'Equipamentos & Presságios',
          color: const Color(0xFF8D6E63),
          visualDensity: VisualDensity.compact,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSurvivor
                ? const Color(0xFF1B5E20).withValues(alpha: 0.3)
                : AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSurvivor
                  ? const Color(0xFF66BB6A).withValues(alpha: 0.5)
                  : AppColors.primaryLight.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSurvivor ? Icons.shield_outlined : Icons.auto_fix_high,
                size: 14,
                color: isSurvivor
                    ? const Color(0xFF66BB6A)
                    : AppColors.primaryLight,
              ),
              const SizedBox(width: 6),
              Text(
                role.displayName,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 12,
                      color: isSurvivor
                          ? const Color(0xFF66BB6A)
                          : AppColors.primaryLight,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBanner(BuildContext context, Haunt haunt) {
    final (color, text) = switch (haunt.category) {
      HauntCategory.semTraidor => (
          AppColors.success,
          'Modo cooperativo — todos os jogadores trabalham juntos'
        ),
      HauntCategory.traidorOculto => (
          AppColors.purple,
          'O traidor começa escondido entre os exploradores.)'
        ),
      HauntCategory.todosContraTodos => (
          AppColors.orange,
          'Modo todos-contra-todos — cada explorador joga por si, todos agem como obstáculo e podem atacar uns aos outros'
        ),
      _ => (AppColors.primary, ''),
    };

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  haunt.category.displayName,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: color,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Haunt haunt) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assombração ${haunt.number.toString().padLeft(2, '0')}',
            style: GoogleFonts.cinzel(
              fontSize: 14,
              color: AppColors.primaryLight,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            haunt.title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: MediaQuery.sizeOf(context).width < 600 ? 22 : 28,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, Haunt haunt) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider),
      ),
      child: Wrap(
        spacing: 24,
        runSpacing: 10,
        children: [
          _MetadataItem(label: 'Traidor', value: haunt.traitorType),
          if (haunt.omenTrigger != null)
            _MetadataItem(label: 'Presságio', value: haunt.omenTrigger!),
          if (haunt.scenarioCard != null)
            _MetadataItem(
                label: 'Cartão de Cenário', value: haunt.scenarioCard!),
        ],
      ),
    );
  }

  Widget _buildIntroduction(BuildContext context, Haunt haunt) {
    return SectionCard(
      title: 'Introdução',
      child: Text(
        haunt.introduction,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
      ),
    );
  }

  Widget _buildSetup(BuildContext context, Haunt haunt) {
    return SectionCard(
      title: 'Preparação',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: haunt.setup.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                  child: Text(
                    '${entry.key + 1}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                ),
                Expanded(
                  child: FormattedText(
                    text: entry.value,
                    baseStyle: Theme.of(context).textTheme.bodyLarge,
                    parseDiceResults: false,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildObjective(BuildContext context, Haunt haunt) {
    return _CollapsibleObjective(objective: haunt.objective!);
  }


  ({List<String> tokens, List<({String header, List<String> items})> tileGroups}) _parseMarkers(Haunt haunt) {
    final lines = haunt.requiredMarkers!.split('\n').where((s) => s.trim().isNotEmpty).toList();
    final tokens = <String>[];
    final tileGroups = <({String header, List<String> items})>[];

    bool isTileHeader(String s) {
      final lower = s.toLowerCase().trim();
      return lower.contains('azulejo') || lower.contains('telha') ||
             (lower.endsWith(':') && (lower.contains('quarto') || lower.contains('sala')));
    }

    for (final line in lines) {
      if (isTileHeader(line)) {
        tileGroups.add((header: line.trim(), items: <String>[]));
      } else if (tileGroups.isNotEmpty) {
        tileGroups.last.items.add(line);
      } else {
        tokens.add(line);
      }
    }

    return (tokens: tokens, tileGroups: tileGroups);
  }

  bool _hasTiles(Haunt haunt) {
    return _parseMarkers(haunt).tileGroups.isNotEmpty;
  }

  Widget _buildMarkers(BuildContext context, Haunt haunt) {
    final parsed = _parseMarkers(haunt);

    if (parsed.tokens.isEmpty) return const SizedBox.shrink();

    return SectionCard(
      title: 'Tokens Necessários',
      accentColor: const Color(0xFF42A5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: parsed.tokens.map((item) => _markerBullet(context, item, const Color(0xFF42A5F5))).toList(),
      ),
    );
  }

  Widget _buildTiles(BuildContext context, Haunt haunt) {
    final groups = _parseMarkers(haunt).tileGroups;

    return Column(
      children: groups.map((group) => SectionCard(
        title: group.header,
        accentColor: AppColors.accent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: group.items.map((item) => _tileBullet(context, item)).toList(),
        ),
      )).toList(),
    );
  }

  Widget _markerBullet(BuildContext context, String item, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, right: 10),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(item.trim(), style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }

  Widget _tileBullet(BuildContext context, String item) {
    final annotated = annotateTileLine(item);
    final dashIdx = annotated.indexOf(RegExp(r'\s–\s'));
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, right: 10),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: dashIdx > 0
                ? RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(text: annotated.substring(0, dashIdx)),
                        TextSpan(
                          text: annotated.substring(dashIdx),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    annotated,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRules(BuildContext context, Haunt haunt) {
    return SectionCard(
      title: 'Regras Especiais',
      accentColor: const Color(0xFFFFCA28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: haunt.specialRules.map((rule) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFFFCA28).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    rule.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFCA28),
                          fontSize: 14,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                FormattedText(
                  text: rule.description,
                  baseStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpecialActions(BuildContext context, Haunt haunt) {
    return SectionCard(
      title: 'Ações Especiais',
      accentColor: const Color(0xFF66BB6A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: haunt.specialActions.map((action) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF66BB6A).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color:
                          const Color(0xFF66BB6A).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'Uma vez durante sua vez, você pode:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF66BB6A),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Text(
                  action.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                FormattedText(
                  text: action.description,
                  baseStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMonsters(BuildContext context, Haunt haunt) {
    return SectionCard(
      title: 'Monstros',
      accentColor: AppColors.accent,
      child: Column(
        children:
            haunt.monsters.map((m) => MonsterStatsCard(monster: m)).toList(),
      ),
    );
  }

  Widget _buildConclusion(BuildContext context, Haunt haunt) {
    return SectionCard(
      title: 'Se Você Vencer',
      accentColor: const Color(0xFF66BB6A),
      child: Text(
        haunt.conclusion!,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.7,
            ),
      ),
    );
  }

  Widget _buildDefeatConclusion(BuildContext context, Haunt haunt) {
    final isHiddenTraitor =
        haunt.category == HauntCategory.traidorOculto;
    return SectionCard(
      title: isHiddenTraitor ? 'Se o Traidor Vencer' : 'Se Você Perder',
      accentColor: const Color(0xFFEF5350),
      child: Text(
        haunt.defeatConclusion!,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.7,
            ),
      ),
    );
  }
}

class _MetadataItem extends StatelessWidget {
  final String label;
  final String value;

  const _MetadataItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _CollapsibleObjective extends StatefulWidget {
  final String objective;
  const _CollapsibleObjective({required this.objective});

  @override
  State<_CollapsibleObjective> createState() => _CollapsibleObjectiveState();
}

class _CollapsibleObjectiveState extends State<_CollapsibleObjective>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _toggle,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.flag, color: AppColors.primaryLight, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Objetivo',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.primaryLight,
                            ),
                      ),
                    ),
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more,
                        color: AppColors.primaryLight.withValues(alpha: 0.7),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipRect(
              child: AnimatedBuilder(
                animation: _heightFactor,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment.topLeft,
                    heightFactor: _heightFactor.value,
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: FormattedText(
                    text: widget.objective,
                    baseStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
