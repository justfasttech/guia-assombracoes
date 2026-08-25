import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FormattedText extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final bool parseDiceResults;

  const FormattedText({
    super.key,
    required this.text,
    this.baseStyle,
    this.parseDiceResults = true,
  });

  @override
  Widget build(BuildContext context) {
    final style = baseStyle ?? Theme.of(context).textTheme.bodyLarge!;
    final processed = _formatPlayerCounts(text);

    if (processed.contains('•')) {
      return _buildWithBullets(context, processed, style);
    }

    if (!parseDiceResults) {
      return Text(processed, style: style);
    }

    return _buildDiceText(context, processed, style);
  }

  Widget _buildWithBullets(BuildContext context, String text, TextStyle style) {
    final parts = text.split('•').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) return const SizedBox.shrink();

    final startsWithBullet = text.trimLeft().startsWith('•');
    final widgets = <Widget>[];

    if (!startsWithBullet && parts.isNotEmpty) {
      widgets.add(parseDiceResults
          ? _buildDiceText(context, parts[0], style)
          : Text(parts[0], style: style));
      if (parts.length > 1) widgets.add(const SizedBox(height: 8));
    }

    final bulletStart = startsWithBullet ? 0 : 1;
    for (int i = bulletStart; i < parts.length; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 6, left: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 7, right: 10),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: (style.color ?? AppColors.textPrimary).withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: parseDiceResults
                  ? _buildDiceText(context, parts[i], style)
                  : Text(parts[i], style: style),
            ),
          ],
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildDiceText(BuildContext context, String text, TextStyle style) {
    final segments = _parse(text);

    if (segments.length == 1 && segments[0] is _TextSeg) {
      return Text(segments[0].content, style: style);
    }

    final widgets = <Widget>[];
    final diceRows = <_DiceSeg>[];

    void flushDice() {
      if (diceRows.isEmpty) return;
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: diceRows.map((d) => _DiceResultRow(seg: d)).toList(),
        ),
      ));
      diceRows.clear();
    }

    for (final seg in segments) {
      if (seg is _TextSeg) {
        flushDice();
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(seg.content, style: style),
        ));
      } else if (seg is _DiceSeg) {
        diceRows.add(seg);
      }
    }
    flushDice();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  static String _formatPlayerCounts(String text) {
    return text.replaceAllMapped(
      RegExp(r'\{(\d+)/(\d+)/(\d+)/(\d+)\}'),
      (m) =>
          ' {${m[1]} / ${m[2]} / ${m[3]} / ${m[4]}} ',
    );
  }

  static List<_Seg> _parse(String text) {
    final segs = <_Seg>[];
    final pattern = RegExp(r'(?:^|(?<=\s|\.))(\d{1,2})\s*([+–-])\s*(\d{0,2})');
    final matches = pattern.allMatches(text).where((m) {
      final n = int.tryParse(m.group(1)!) ?? -1;
      return n >= 0 && n <= 20;
    }).toList();

    if (matches.isEmpty) {
      return [_TextSeg(text.trim())];
    }

    int lastEnd = 0;
    for (int i = 0; i < matches.length; i++) {
      final m = matches[i];
      if (m.start > lastEnd) {
        final before = text.substring(lastEnd, m.start).trim();
        if (before.isNotEmpty) segs.add(_TextSeg(before));
      }

      final op = m.group(2)!;
      final n3 = m.group(3)!;
      final val = n3.isNotEmpty ? '${m.group(1)}$op$n3' : '${m.group(1)}+';
      final isHigh = op == '+' || (int.tryParse(m.group(1)!) ?? 0) >= 5;

      int rEnd = i + 1 < matches.length ? matches[i + 1].start : text.length;
      final result = text.substring(m.end, rEnd).trim();
      segs.add(_DiceSeg(val, result, isHigh));
      lastEnd = rEnd;
    }

    if (lastEnd < text.length) {
      final rem = text.substring(lastEnd).trim();
      if (rem.isNotEmpty) segs.add(_TextSeg(rem));
    }

    return segs;
  }
}

abstract class _Seg {
  String get content;
}

class _TextSeg extends _Seg {
  @override
  final String content;
  _TextSeg(this.content);
}

class _DiceSeg extends _Seg {
  final String value;
  final String result;
  final bool isHighResult;
  _DiceSeg(this.value, this.result, this.isHighResult);
  @override
  String get content => '$value $result';
}

class _DiceResultRow extends StatelessWidget {
  final _DiceSeg seg;

  const _DiceResultRow({required this.seg});

  @override
  Widget build(BuildContext context) {
    final color = seg.isHighResult
        ? const Color(0xFF66BB6A)
        : const Color(0xFFEF5350);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(7)),
            ),
            child: Text(
              seg.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text(
                seg.result,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
