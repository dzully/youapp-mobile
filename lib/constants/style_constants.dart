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

// Colors
const kPrimaryColor = Color(0xFF62CDCB);

// Padding
const kScreenPadding = EdgeInsets.all(20.0);

const kSecondaryButtonStyle = TextStyle(
  color: kSecondaryColor,
);

const kSecondaryColor = Color(0xFFD4AF37);

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
