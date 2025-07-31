import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

///This class control the route animation of the app each function have
/// it own behaviour
class RouteAnimation {
  ///Navigate from center right of screen to the center left with transition
  ///of time
  static CustomTransitionPage<dynamic> animatedPageFromCenterRightToCenterLeft(
      GoRouterState state, Widget widget) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      child: widget,
      transitionDuration: const Duration(
        milliseconds: 350,
      ),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        ///start point of the screen
        const Offset begin = Offset(1.0, 0.0);

        ///end point of the screen
        const Offset end = Offset.zero;

        ///animation of creating the screen
        const Cubic curve = Curves.easeInOut;

        ///animation control
        final Animatable<Offset> tween =
            Tween<Offset>(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  ///Navigate from bottom to top with transition of time
  static CustomTransitionPage<dynamic> animatedPageFromBottomToTop(
      GoRouterState state, Widget widget) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      child: widget,
      transitionDuration: const Duration(
        milliseconds: 350,
      ),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        ///start point of the screen
        const Offset begin = Offset(0.0, 1.0);

        ///end point of the screen
        const Offset end = Offset.zero;

        ///animation of creating the screen
        const Cubic curve = Curves.easeInOut;

        ///animation control
        final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  ///Navigate from bottom left to the top right with transition of time
  static CustomTransitionPage<dynamic> animatedPageFromBottomLeftToTopRight(
      GoRouterState state, Widget widget) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      child: widget,
      transitionDuration: const Duration(
        milliseconds: 350,
      ),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        ///start point of the screen
        const Offset begin = Offset(1.0, 1.0);

        ///end point of the screen
        const Offset end = Offset.zero;

        ///animation of creating the screen
        const Cubic curve = Curves.easeInOut;

        ///animation control
        final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
