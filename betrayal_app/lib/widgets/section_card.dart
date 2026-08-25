import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SectionCard extends StatefulWidget {
  final String title;
  final Widget child;
  final Color accentColor;
  final bool initiallyExpanded;

  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.accentColor = AppColors.primary,
    this.initiallyExpanded = false,
  });

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
      value: _expanded ? 1.0 : 0.0,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: widget.accentColor.withValues(alpha: 0.08),
                  border: Border(
                    bottom: _expanded
                        ? BorderSide(color: AppColors.divider)
                        : BorderSide.none,
                    left:
                        BorderSide(color: widget.accentColor, width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more,
                        color: widget.accentColor.withValues(alpha: 0.7),
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
                  padding: const EdgeInsets.all(16),
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
