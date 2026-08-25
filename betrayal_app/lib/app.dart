import 'package:flutter/material.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class BetrayalApp extends StatelessWidget {
  const BetrayalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Betrayal - Guia de Assombrações',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
