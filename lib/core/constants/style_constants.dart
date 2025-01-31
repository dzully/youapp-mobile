import 'package:flutter/material.dart';

// Gradients
const kBackgroundGradient = RadialGradient(
  center: Alignment(1.0, -0.3),
  radius: 1.2,
  colors: kBackgroundGradientColors,
  stops: kBackgroundGradientStops,
);

const kBackgroundGradientColors = [
  Color(0xFF1F4247),
  Color(0xFF0D1D23),
  Color(0xFF09141A),
];

const kBackgroundGradientStops = [0.0, 0.5618, 1.0];

// Border Radius
const kBorderRadius = BorderRadius.all(Radius.circular(15));

const kCardPadding = EdgeInsets.all(12.0);

const kCardSubtitleStyle = TextStyle(
  color: Colors.grey,
);
const kCardTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
);
// Text Styles
const kHeadlineStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

/// Gradient constants
const kHomeBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF1D1D1D),
    Color(0xFF24786D),
  ],
);

/// Color constants
const kPrimaryColor = Color(0xFF1D1D1D);

// Padding
const kScreenPadding = EdgeInsets.all(20.0);
const kSecondaryButtonStyle = TextStyle(
  color: kSecondaryColor,
);

const kSecondaryColor = Color(0xFF24786D);

const kSubheadStyle = TextStyle(
  color: Colors.white70,
  fontSize: 16,
);

// Button Styles
final kPrimaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  foregroundColor: Colors.white,
  minimumSize: const Size(double.infinity, 50),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
  ),
);

/// Animation Duration constants
class AnimationDurations {
  static const Duration short = Duration(milliseconds: 300);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration long = Duration(milliseconds: 800);
}

/// Spacing constants
class Spacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}
