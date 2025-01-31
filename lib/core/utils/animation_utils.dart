import 'package:flutter/material.dart';

class AnimationUtils {
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);

  static const Curve entranceCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;
  
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve reverseBounce = Curves.elasticIn;
}