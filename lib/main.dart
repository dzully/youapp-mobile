import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AvatarCircles extends StatefulWidget {
  const AvatarCircles({super.key});

  @override
  State<AvatarCircles> createState() => _AvatarCirclesState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotificationScreen(),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final String name;
  final String action;
  final String avatarUrl;
  final String time;

  const NotificationCard({
    super.key,
    required this.name,
    required this.action,
    required this.avatarUrl,
    required this.time,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Animated Time Display
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: const Text(
                      '9:41',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              // Notification Cards with staggered animation
              NotificationCard(
                name: 'Lia Marie',
                action: 'Added 23 photos to Outings.',
                avatarUrl:
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop&crop=faces',
                time: '20m',
              ),
              const SizedBox(height: 10),
              NotificationCard(
                name: 'Thom Avril',
                action: 'Is eating at Dome, Joondalup.',
                avatarUrl:
                    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=faces',
                time: '30m',
              ),
              const SizedBox(height: 40),
              // Avatar Circles with floating animation
              const AvatarCircles(),
              const SizedBox(height: 40),
              // Animated bottom content
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text(
                      "Don't miss out on what your\nfriends are up to",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Never miss those precious moments.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text('Turn on notifications'),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Another time',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarCirclesState extends State<AvatarCircles>
    with TickerProviderStateMixin {
  // List of Unsplash image URLs for avatars
  final List<String> avatarUrls = const [
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e',
    'https://images.unsplash.com/photo-1527980965255-d3b416303d12',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
    'https://images.unsplash.com/photo-1517841905240-472988babdf9',
    'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
  ];

  late List<AnimationController> _floatControllers;
  late List<Animation<double>> _floatAnimations;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(
        avatarUrls.length,
        (index) => AnimatedBuilder(
          animation: _floatAnimations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatAnimations[index].value),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 500 + (index * 100)),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: () => _onAvatarTap(index),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.primaries[index % Colors.primaries.length]
                          .withOpacity(0.2),
                    ),
                    child: Hero(
                      tag: 'avatar_$index',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${avatarUrls[index]}?w=150&h=150&fit=crop&crop=faces',
                        ),
                        radius: 25,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _floatControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _floatControllers = List.generate(
      avatarUrls.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      ),
    );

    _floatAnimations = _floatControllers.map((controller) {
      return Tween<double>(begin: -5, end: 5).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Start animations with different delays
    for (var i = 0; i < _floatControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          _floatControllers[i].repeat(reverse: true);
        }
      });
    }
  }

  void _onAvatarTap(int index) {
    // Reset the animation on tap for a bounce effect
    _floatControllers[index].stop();
    _floatControllers[index].reset();
    _floatControllers[index].repeat(reverse: true);
  }
}

class _NotificationCardState extends State<NotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  // Outer glow effect
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.03),
                    spreadRadius: 7,
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                  // Inner sharper glow
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.05),
                    spreadRadius: 3,
                    blurRadius: 12,
                    offset: const Offset(0, 0),
                  ),
                  // Subtle white glow for depth
                  const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.avatarUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.action,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }
}
