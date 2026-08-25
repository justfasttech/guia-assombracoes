import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'models/haunt_role.dart';
import 'pages/home_page.dart';
import 'pages/haunt_list_page.dart';
import 'pages/haunt_detail_page.dart';
import 'pages/events_page.dart';
import 'pages/cards_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: '/eventos',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const EventsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: '/cartas',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CardsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: '/sobrevivente',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HauntListPage(role: HauntRole.survivor),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return CustomTransitionPage(
              key: state.pageKey,
              child: HauntDetailPage(role: HauntRole.survivor, hauntId: id),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/traidor',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HauntListPage(role: HauntRole.traitor),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return CustomTransitionPage(
              key: state.pageKey,
              child: HauntDetailPage(role: HauntRole.traitor, hauntId: id),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      ],
    ),
  ],
);
