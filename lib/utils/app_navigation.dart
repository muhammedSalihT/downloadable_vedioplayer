import 'package:flutter/material.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static push({context, newRoute, materialRoutePage}) {
    Navigator.push(
      context,
      newRoute ??
          MaterialPageRoute(
            builder: (_) => materialRoutePage,
          ),
    );
  }

  static pushAndReplace({context, newRoute, materialRoutePage}) {
    Navigator.pushReplacement(
      context,
      newRoute ??
          MaterialPageRoute(
            builder: (_) => materialRoutePage,
          ),
    );
  }

  static pushAndRemoveUntil({context, newRoute, materialRoutePage}) {
    Navigator.pushAndRemoveUntil(
      context,
      newRoute ??
          MaterialPageRoute(
            builder: (_) => materialRoutePage,
          ),
      (_) => false,
    );
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Route createCustomRoute(
      {page,
      TransitionType? transitionType = TransitionType.slideRight,
      slideExitPage,
      slideEnterPage,
      Duration? reverseTransitionDuration,
      Duration? transitionDuration}) {
    return PageRouteBuilder(
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 200),
      reverseTransitionDuration:
          reverseTransitionDuration ?? const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (transitionType == TransitionType.slideBottom) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: page,
          );
        } else if (transitionType == TransitionType.slideRight) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: page,
          );
        } else if (transitionType == TransitionType.slideLeft) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: page,
          );
        } else if (transitionType == TransitionType.fade) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        } else if (transitionType == TransitionType.size) {
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        } else if (transitionType == TransitionType.scale) {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        } else if (transitionType == TransitionType.scaleCenter) {
          return ScaleTransition(
            alignment: Alignment.centerRight,
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        } else if (transitionType == TransitionType.scaleRight) {
          return ScaleTransition(
            alignment: Alignment.topRight,
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        } else if (transitionType == TransitionType.scaleLeft) {
          return ScaleTransition(
            alignment: Alignment.topLeft,
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        } else {
          return Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: slideExitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: slideEnterPage,
              )
            ],
          );
        }
      },
    );
  }
}

enum TransitionType {
  slideRight,
  slideLeft,
  slideBottom,
  scale,
  size,
  fade,
  scaleLeft,
  scaleRight,
  scaleCenter
}
