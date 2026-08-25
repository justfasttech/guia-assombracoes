import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.maxWidth = 700,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width < 600 ? 16 : 24,
          ),
          child: child,
        ),
      ),
    );
  }
}
