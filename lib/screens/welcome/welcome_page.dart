import 'package:flutter/material.dart';
import 'package:youapp/screens/auth/login_page.dart';
import 'package:youapp/screens/auth/register_page.dart';

import '../../core/constants/style_constants.dart';
import './components/animated_text.dart';
import './components/avatar_circles.dart';
import './components/welcome_card.dart'; // Rename this import if you rename the component

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: kBackgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: kScreenPadding,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const AnimatedAppTitle(),
                  const SizedBox(height: 30),
                  _buildWelcomeCards(),
                  const SizedBox(height: 40),
                  const AvatarCircles(),
                  const SizedBox(height: 40),
                  _buildWelcomeContent(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginPage())),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF62CDCB),
                  Color(0xFF4599DB),
                ],
                begin: Alignment(-0.3, 0.0),
                end: Alignment(1.0, 0.0),
                stops: [0.2488, 0.7849],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF62CDCB).withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFF4599DB).withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            width: double.infinity,
            height: 56,
            alignment: Alignment.center,
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => RegisterPage())),
          child: const Text(
            'Register',
            style: kSecondaryButtonStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCards() {
    return Column(
      children: [
        WelcomeCard(
          // Consider renaming this component to WelcomeCard
          name: 'Lia Marie',
          action: 'Added 23 photos to Outings.',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
          time: '20m',
        ),
        const SizedBox(height: 20),
        WelcomeCard(
          // Consider renaming this component to WelcomeCard
          name: 'Thom Avril',
          action: 'Is eating at Dome, Joondalup.',
          avatarUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e',
          time: '30m',
        ),
      ],
    );
  }

  Widget _buildWelcomeContent(BuildContext context) {
    return AnimatedOpacityTransition(
      child: Column(
        children: [
          Text(
            "Welcome to YouApp\nConnect with friends",
            textAlign: TextAlign.center,
            style: kHeadlineStyle,
          ),
          const SizedBox(height: 10),
          Text(
            'Join our community today',
            style: kSubheadStyle,
          ),
          const SizedBox(height: 20),
          _buildAuthButtons(context),
        ],
      ),
    );
  }
}
