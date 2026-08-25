import '../models/haunt.dart';
import '../models/haunt_category.dart';
import '../models/haunt_role.dart';
import 'survivor_haunts_data.dart';
import 'traitor_haunts_data.dart';

class HauntsRepository {
  static Map<int, Haunt> _getMap(HauntRole role) =>
      role == HauntRole.survivor ? survivorHaunts : traitorHaunts;

  static List<Haunt> getHaunts(HauntRole role) =>
      _getMap(role).values.toList()
        ..sort((a, b) => a.number.compareTo(b.number));

  static Map<HauntCategory, List<Haunt>> getHauntsByCategory(HauntRole role) {
    final haunts = getHaunts(role);
    final grouped = <HauntCategory, List<Haunt>>{};
    for (final category in HauntCategory.values) {
      final list = haunts.where((h) => h.category == category).toList();
      if (list.isNotEmpty) {
        grouped[category] = list;
      }
    }
    return grouped;
  }

  static List<Haunt> search(HauntRole role, String query) {
    final q = query.toLowerCase();
    return getHaunts(role)
        .where((h) =>
            h.number.toString().contains(q) ||
            h.title.toLowerCase().contains(q))
        .toList();
  }

  static List<Haunt> filterByRange(HauntRole role, int start, int end) =>
      getHaunts(role)
          .where((h) => h.number >= start && h.number <= end)
          .toList();

  static Haunt? getHaunt(HauntRole role, int number) => _getMap(role)[number];
}
