import 'package:flutter/material.dart';
import 'package:youapp/screens/auth/login_page.dart';
import 'package:youapp/screens/auth/register_page.dart';

import '../components/animated_text.dart';
import '../components/avatar_circles.dart';
import '../components/notification_card.dart';
import '../constants/style_constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
                  _buildNotificationCards(),
                  const SizedBox(height: 40),
                  const AvatarCircles(),
                  const SizedBox(height: 40),
                  _buildBottomContent(context),
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
          style: kPrimaryButtonStyle,
          child: const Text('Login'),
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

  Widget _buildBottomContent(BuildContext context) {
    return AnimatedOpacityTransition(
      child: Column(
        children: [
          Text(
            "Don't miss out on what your\nfriends are up to",
            textAlign: TextAlign.center,
            style: kHeadlineStyle,
          ),
          const SizedBox(height: 10),
          Text(
            'Never miss those precious moments.',
            style: kSubheadStyle,
          ),
          const SizedBox(height: 20),
          _buildAuthButtons(context),
        ],
      ),
    );
  }

  Widget _buildNotificationCards() {
    return Column(
      children: [
        NotificationCard(
          name: 'Lia Marie',
          action: 'Added 23 photos to Outings.',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
          time: '20m',
        ),
        const SizedBox(height: 20),
        NotificationCard(
          name: 'Thom Avril',
          action: 'Is eating at Dome, Joondalup.',
          avatarUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e',
          time: '30m',
        ),
      ],
    );
  }
}
