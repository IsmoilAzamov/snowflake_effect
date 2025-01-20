 import 'package:flutter/cupertino.dart';

Widget animatedText(String text) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 600),  // Longer duration for smoother animation
    switchInCurve: Curves.easeInOut,  // Smooth in-out curve
    switchOutCurve: Curves.easeInOut,  // Smooth in-out curve
    transitionBuilder: (Widget child, Animation<double> animation) {
      // Combine multiple animations: fade, scale, and slide
      return FadeTransition(
        opacity: animation,  // Fade effect
        child: ScaleTransition(
          scale: animation,  // Scale effect
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.2, 0),  // Slide from right
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      );
    },
    child: Text(
      text,
      key: ValueKey(text),
    ),
  );
}