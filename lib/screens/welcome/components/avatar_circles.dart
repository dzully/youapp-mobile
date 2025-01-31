import 'package:flutter/material.dart';

import '../../../core/utils/animation_utils.dart';

class AvatarCircles extends StatefulWidget {
  const AvatarCircles({super.key});

  @override
  State<AvatarCircles> createState() => _AvatarCirclesState();
}

class _AvatarCirclesState extends State<AvatarCircles>
    with TickerProviderStateMixin {
  late final List<AnimationController> _floatControllers;
  late final List<Animation<double>> _floatAnimations;
  final _avatarUrls = List.generate(
      8,
      (i) => 'https://images.unsplash.com/photo-${[
            '1494790108377-be9c29b29330',
            '1438761681033-6461ffad8d80',
            '1472099645785-5658abf4ff4e',
            '1527980965255-d3b416303d12',
            '1544005313-94ddf0286df2',
            '1517841905240-472988babdf9',
            '1539571696357-5a69c17a67c6',
            '1507003211169-0a1dd7228f2d',
          ][i]}');

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(
        _avatarUrls.length,
        (index) => _buildAnimatedAvatar(index),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _floatControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _floatControllers = List.generate(
      _avatarUrls.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      ),
    );

    _floatAnimations = _floatControllers.map((controller) {
      return Tween<double>(begin: -5, end: 5).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startAnimationsWithDelay();
  }

  Widget _buildAnimatedAvatar(int index) {
    return AnimatedBuilder(
      animation: _floatAnimations[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimations[index].value),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 500 + (index * 100)),
            curve: AnimationUtils.entranceCurve,
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
                      '${_avatarUrls[index]}?w=150&h=150&fit=crop&crop=faces',
                    ),
                    radius: 25,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onAvatarTap(int index) {
    _floatControllers[index]
      ..stop()
      ..reset()
      ..repeat(reverse: true);
  }

  void _startAnimationsWithDelay() {
    for (var i = 0; i < _floatControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) _floatControllers[i].repeat(reverse: true);
      });
    }
  }
}
