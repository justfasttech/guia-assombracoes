import 'haunt_category.dart';
import 'monster.dart';
import 'special_action.dart';
import 'special_rule.dart';

class Haunt {
  final int number;
  final String title;
  final HauntCategory category;
  final String traitorType;
  final String? scenarioCard;
  final String? omenTrigger;
  final String introduction;
  final List<String> setup;
  final String? objective;
  final String? requiredMarkers;
  final List<SpecialRule> specialRules;
  final List<SpecialAction> specialActions;
  final List<Monster> monsters;
  final String? conclusion;
  final String? defeatConclusion;

  const Haunt({
    required this.number,
    required this.title,
    required this.category,
    required this.traitorType,
    this.scenarioCard,
    this.omenTrigger,
    required this.introduction,
    this.setup = const [],
    this.objective,
    this.requiredMarkers,
    this.specialRules = const [],
    this.specialActions = const [],
    this.monsters = const [],
    this.conclusion,
    this.defeatConclusion,
  });
}
