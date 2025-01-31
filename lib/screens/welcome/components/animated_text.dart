import 'package:flutter/material.dart';

import '../../../core/utils/animation_utils.dart';

class AnimatedAppTitle extends StatelessWidget {
  const AnimatedAppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: AnimationUtils.mediumAnimationDuration,
      curve: AnimationUtils.entranceCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: const Text(
            'YouApp',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              fontFamily: 'Chicle',
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class AnimatedOpacityTransition extends StatelessWidget {
  final Widget child;

  const AnimatedOpacityTransition({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: AnimationUtils.mediumAnimationDuration,
      curve: AnimationUtils.exitCurve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
