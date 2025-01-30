import 'package:flutter/material.dart';

import '../constants/style_constants.dart';

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

class _NotificationCardState extends State<NotificationCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Color?> _colorAnimation;

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
              padding: kCardPadding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: kBorderRadius,
                boxShadow: [
                  BoxShadow(
                    color: _colorAnimation.value ??
                        Colors.purple.withOpacity(0.03),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.05),
                    spreadRadius: 3,
                    blurRadius: 12,
                  ),
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
                    backgroundImage: NetworkImage(
                        '${widget.avatarUrl}?w=150&h=150&fit=crop&crop=faces'),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name, style: kCardTitleStyle),
                        Text(widget.action, style: kCardSubtitleStyle),
                      ],
                    ),
                  ),
                  Text(widget.time, style: kCardSubtitleStyle),
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
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.purple).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }
}
