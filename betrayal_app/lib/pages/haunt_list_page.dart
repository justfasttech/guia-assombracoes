import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/haunts_repository.dart';
import '../models/haunt.dart';
import '../models/haunt_category.dart';
import '../models/haunt_role.dart';
import '../theme/app_colors.dart';
import '../widgets/category_header.dart';
import '../widgets/haunt_list_item.dart';
import '../widgets/range_filter_tabs.dart';
import '../widgets/responsive_layout.dart';

class HauntListPage extends StatefulWidget {
  final HauntRole role;

  const HauntListPage({super.key, required this.role});

  @override
  State<HauntListPage> createState() => _HauntListPageState();
}

class _HauntListPageState extends State<HauntListPage> {
  String _searchQuery = '';
  int? _selectedRange;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Haunt> get _filteredHaunts {
    var haunts = HauntsRepository.getHaunts(widget.role);

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      haunts = haunts
          .where((h) =>
              h.number.toString().contains(q) ||
              h.title.toLowerCase().contains(q))
          .toList();
    }

    if (_selectedRange != null) {
      final start = _selectedRange!;
      final end = start + 9;
      haunts = haunts
          .where((h) => h.number >= start && h.number <= end)
          .toList();
    }

    return haunts;
  }

  Map<HauntCategory, List<Haunt>> get _groupedHaunts {
    final haunts = _filteredHaunts;
    final grouped = <HauntCategory, List<Haunt>>{};
    for (final category in HauntCategory.values) {
      final categoryHaunts =
          haunts.where((h) => h.category == category).toList();
      if (categoryHaunts.isNotEmpty) {
        grouped[category] = categoryHaunts;
      }
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupedHaunts;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveLayout(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => context.go('/'),
                        icon: const Icon(Icons.swap_horiz, size: 18),
                        label: const Text('Trocar papel'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          widget.role.displayName,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.primaryLight,
                                    fontSize: 13,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Assombrações',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText:
                          'Buscar pelo número ou nome da assombração',
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.textSecondary),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear,
                                  color: AppColors.textSecondary),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RangeFilterTabs(
                    selectedRange: _selectedRange,
                    onRangeSelected: (v) =>
                        setState(() => _selectedRange = v),
                  ),
                ),
              ),
              if (grouped.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.search_off,
                              size: 48, color: AppColors.textSecondary),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhuma assombração encontrada',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                ...grouped.entries.expand((entry) => [
                      SliverToBoxAdapter(
                        child: CategoryHeader(
                          category: entry.key,
                          count: entry.value.length,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final haunt = entry.value[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: HauntListItem(
                                haunt: haunt,
                                onTap: () => context.go(
                                  '/${widget.role.urlPath}/${haunt.number}',
                                ),
                              ),
                            );
                          },
                          childCount: entry.value.length,
                        ),
                      ),
                    ]),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }
}
