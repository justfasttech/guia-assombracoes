import 'event_card.dart';

enum GameCardType { item, omen }

class GameCard {
  final String title;
  final String? subtitle;
  final String flavorText;
  final String description;
  final String? note;
  final GameCardType type;
  final List<DiceResult> diceResults;

  const GameCard({
    required this.title,
    this.subtitle,
    required this.flavorText,
    required this.description,
    this.note,
    required this.type,
    this.diceResults = const [],
  });
}
