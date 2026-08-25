import 'special_action.dart';

class Monster {
  final String name;
  final String? strength;
  final String? speed;
  final String? sanity;
  final String? knowledge;
  final String? description;
  final List<SpecialAction> actions;

  const Monster({
    required this.name,
    this.strength,
    this.speed,
    this.sanity,
    this.knowledge,
    this.description,
    this.actions = const [],
  });
}
