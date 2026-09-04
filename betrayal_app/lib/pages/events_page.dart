import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/events_data.dart';
import '../data/pennywise_data.dart';
import '../models/event_card.dart';
import '../theme/app_colors.dart';

const _eventYellow = Color(0xFFD4A017);
const _pennywiseRed = Color(0xFFE53935);

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventCard? _drawnEvent;
  bool _showList = false;
  String _search = '';
  final _searchController = TextEditingController();
  bool _showSearch = false;
  bool _showPennywise = false;

  List<EventCard> get _activeList =>
      _showPennywise ? allPennywiseEncounters : allEvents;

  Color get _activeColor => _showPennywise ? _pennywiseRed : _eventYellow;

  List<EventCard> get _filteredEvents {
    final source = _activeList;
    if (_search.isEmpty) return source;
    final query = _search.toLowerCase();
    return source.where((e) => e.title.toLowerCase().contains(query)).toList();
  }

  void _drawRandom() {
    final source = _activeList;
    setState(() {
      _drawnEvent = source[Random().nextInt(source.length)];
      _showList = false;
    });
  }

  void _switchSection(bool pennywise) {
    if (_showPennywise == pennywise) return;
    setState(() {
      _showPennywise = pennywise;
      _drawnEvent = null;
      _showList = false;
      _search = '';
      _searchController.clear();
      _showSearch = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSectionTabs(),
            if (_showSearch) _buildSearchBar(),
            _buildActions(),
            const Divider(color: AppColors.divider, height: 1),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final color = _activeColor;
    final title = _showPennywise ? 'Encontros do Pennywise' : 'Cartas de Evento';
    final count = _activeList.length;
    final subtitle = _showPennywise
        ? '$count encontros disponíveis'
        : '$count eventos disponíveis';
    final icon = _showPennywise ? Icons.mood_bad : Icons.auto_stories;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.textSecondary),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 18,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() {
              _showSearch = !_showSearch;
              if (!_showSearch) {
                _search = '';
                _searchController.clear();
              }
            }),
            icon: Icon(
              _showSearch ? Icons.search_off : Icons.search,
              color: _showSearch ? color : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: _SectionTab(
              label: 'Eventos',
              icon: Icons.auto_stories,
              selected: !_showPennywise,
              color: _eventYellow,
              onTap: () => _switchSection(false),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _SectionTab(
              label: 'Pennywise',
              icon: Icons.mood_bad,
              selected: _showPennywise,
              color: _pennywiseRed,
              onTap: () => _switchSection(true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final color = _activeColor;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: (v) => setState(() => _search = v),
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Pesquisar pelo título...',
          hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.6)),
          prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.textSecondary),
          suffixIcon: _search.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () => setState(() {
                    _search = '';
                    _searchController.clear();
                  }),
                )
              : null,
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color),
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    final color = _activeColor;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.casino,
              label: 'Sortear',
              selected: !_showList,
              onTap: _drawRandom,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.list_alt,
              label: 'Lista Completa',
              selected: _showList,
              onTap: () => setState(() {
                _showList = true;
                _drawnEvent = null;
              }),
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final color = _activeColor;

    if (_showList) {
      final events = _filteredEvents;
      if (events.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Text(
              _showPennywise
                  ? 'Nenhum encontro encontrado.'
                  : 'Nenhum evento encontrado.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: events.length,
        itemBuilder: (context, index) =>
            _EventCardWidget(event: events[index], themeColor: color),
      );
    }

    if (_drawnEvent != null) {
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: _EventCardWidget(
            event: _drawnEvent!, highlighted: true, themeColor: color),
      );
    }

    final emptyText = _showPennywise
        ? 'Toque em "Sortear" para revelar um encontro aleatório do Pennywise ou veja a lista completa.'
        : 'Toque em "Sortear" para revelar um evento aleatório ou veja a lista completa.';

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _showPennywise ? Icons.mood_bad : Icons.touch_app,
            size: 48,
            color: color.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            emptyText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _SectionTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _SectionTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color.withValues(alpha: 0.12) : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? color.withValues(alpha: 0.5) : AppColors.divider,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: selected ? color : AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? color : AppColors.textSecondary,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? color.withValues(alpha: 0.15)
          : AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? color.withValues(alpha: 0.5)
                  : AppColors.divider,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: selected ? color : AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: selected ? color : AppColors.textSecondary,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCardWidget extends StatelessWidget {
  final EventCard event;
  final bool highlighted;
  final Color themeColor;

  const _EventCardWidget({
    required this.event,
    this.highlighted = false,
    this.themeColor = _eventYellow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlighted
              ? themeColor.withValues(alpha: 0.5)
              : AppColors.divider,
          width: highlighted ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Text(
              event.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
            ),
          ),
          if (event.condition != null) _buildCondition(context),
          if (event.additionalEffect != null) _buildAdditionalEffect(context),
          if (event.testType != null || event.rollInstruction != null)
            _buildTestType(context),
          if (event.diceResults.isNotEmpty) _buildDiceTable(context),
          if (event.note != null) _buildNote(context),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: themeColor.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
        border: Border(bottom: BorderSide(color: themeColor.withValues(alpha: 0.2))),
      ),
      child: Text(
        event.title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: themeColor,
              fontSize: 16,
            ),
      ),
    );
  }

  Widget _buildCondition(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, size: 16, color: AppColors.purple.withValues(alpha: 0.8)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              event.condition!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFCE93D8),
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalEffect(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF42A5F5).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF42A5F5).withValues(alpha: 0.3)),
      ),
      child: Text(
        event.additionalEffect!,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF90CAF9),
              fontSize: 13,
              height: 1.5,
            ),
      ),
    );
  }

  Widget _buildTestType(BuildContext context) {
    final label = event.testType != null
        ? 'Faça um teste de ${event.testType}'
        : event.rollInstruction!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: themeColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.casino, size: 14, color: themeColor),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: themeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceTable(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: AppColors.surfaceLight,
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      'Dados',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Resultado',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            ...event.diceResults.asMap().entries.map((entry) {
              final isEven = entry.key % 2 == 0;
              final result = entry.value;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: isEven ? AppColors.surface : AppColors.background,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: themeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          result.range,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                                fontSize: 13,
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result.effect,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                          ),
                          if (result.flavorText != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              result.flavorText!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNote(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 14, color: AppColors.orange.withValues(alpha: 0.8)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              event.note!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFFFCC80),
                    fontSize: 12,
                    height: 1.4,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
