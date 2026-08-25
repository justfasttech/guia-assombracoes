import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/cards_data.dart';
import '../models/game_card.dart';
import '../theme/app_colors.dart';

const _itemColor = Color(0xFF8D6E63);
const _omenColor = Color(0xFF4CAF50);

enum _Filter { all, items, omens }

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  _Filter _filter = _Filter.all;
  String _search = '';
  final _searchController = TextEditingController();
  bool _showSearch = false;

  List<GameCard> get _filteredCards {
    final cards = switch (_filter) {
      _Filter.all => [...allItems, ...allOmens],
      _Filter.items => allItems,
      _Filter.omens => allOmens,
    };
    if (_search.isEmpty) return cards;
    final query = _search.toLowerCase();
    return cards.where((c) => c.title.toLowerCase().contains(query)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = _filteredCards;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            if (_showSearch) _buildSearchBar(),
            _buildFilters(),
            const Divider(color: AppColors.divider, height: 1),
            Expanded(
              child: cards.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          'Nenhuma carta encontrada.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: cards.length,
                      itemBuilder: (context, index) =>
                          _GameCardWidget(card: cards[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
              color: _itemColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2, color: _itemColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Equipamentos & Presságios',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                ),
                Text(
                  '${allItems.length} equipamentos · ${allOmens.length} presságios',
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
              color: _showSearch ? AppColors.primaryLight : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
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
            borderSide: const BorderSide(color: _itemColor),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          _FilterChip(
            label: 'Todos',
            selected: _filter == _Filter.all,
            color: AppColors.textPrimary,
            onTap: () => setState(() => _filter = _Filter.all),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Equipamentos',
            selected: _filter == _Filter.items,
            color: _itemColor,
            onTap: () => setState(() => _filter = _Filter.items),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Presságios',
            selected: _filter == _Filter.omens,
            color: _omenColor,
            onTap: () => setState(() => _filter = _Filter.omens),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.15) : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color.withValues(alpha: 0.5) : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? color : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _GameCardWidget extends StatelessWidget {
  final GameCard card;

  const _GameCardWidget({required this.card});

  Color get _accentColor =>
      card.type == GameCardType.item ? _itemColor : _omenColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              card.flavorText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              card.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    height: 1.5,
                  ),
            ),
          ),
          if (card.diceResults.isNotEmpty) _buildDiceTable(context),
          if (card.note != null) _buildNote(context),
          if (card.type == GameCardType.omen) _buildOmenNote(context),
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
        color: _accentColor.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
        border: Border(bottom: BorderSide(color: _accentColor.withValues(alpha: 0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              card.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _accentColor,
                    fontSize: 16,
                  ),
            ),
          ),
          if (card.subtitle != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                card.subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
              ),
            ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _accentColor.withValues(alpha: 0.2)),
            ),
            child: Text(
              card.type == GameCardType.item ? 'Equipamento' : 'Presságio',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _accentColor.withValues(alpha: 0.8),
                    fontSize: 10,
                  ),
            ),
          ),
        ],
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
          children: card.diceResults.asMap().entries.map((entry) {
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
                        color: _accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        result.range,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _accentColor,
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
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
          }).toList(),
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
              card.note!,
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

  Widget _buildOmenNote(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _omenColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _omenColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, size: 14, color: _omenColor.withValues(alpha: 0.8)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Quando esta carta for comprada, faça um teste de assombração. Ignore este teste se a assombração já tiver começado.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _omenColor.withValues(alpha: 0.9),
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
