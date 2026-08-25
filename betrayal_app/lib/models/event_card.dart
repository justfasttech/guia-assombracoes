class DiceResult {
  final String range;
  final String effect;
  final String? flavorText;

  const DiceResult({
    required this.range,
    required this.effect,
    this.flavorText,
  });
}

class EventCard {
  final String title;
  final String description;
  final String? condition;
  final String? testType;
  final String? rollInstruction;
  final List<DiceResult> diceResults;
  final String? additionalEffect;
  final String? note;

  const EventCard({
    required this.title,
    required this.description,
    this.condition,
    this.testType,
    this.rollInstruction,
    this.diceResults = const [],
    this.additionalEffect,
    this.note,
  });
}
