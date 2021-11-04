import 'package:flutter/material.dart';

/// Animation types
enum AnimationType {
  normal,
  fadeIn,
}

/// Main class, [context] build context at the moment
/// [child] Widget to navigate, [animation] type animation
class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final bool replacement;

  RouteTransitions({
    required this.context,
    required this.child,
    this.animation = AnimationType.normal,
    this.duration = const Duration(milliseconds: 300),
    this.replacement = false,
  }) {
    switch (animation) {
      case AnimationType.normal:
        _normalTransition();
        break;
      case AnimationType.fadeIn:
        _fadeInTransition();
        break;
    }
  }

  /// Push page
  void _pushPage(Route route) => Navigator.push(context, route);

  /// PushReplacement page
  void _pushReplacementPage(Route route) =>
      Navigator.pushReplacement(context, route);

  /// Normal transition
  void _normalTransition() {
    final route = MaterialPageRoute(builder: (_) => child);
    (replacement) ? _pushReplacementPage(route) : _pushPage(route);
  }

  /// Transition Controller with fadeIn
  void _fadeInTransition() {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionDuration: duration,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          child: child,
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
        );
      },
    );

    (replacement) ? _pushReplacementPage(route) : _pushPage(route);
  }
}
