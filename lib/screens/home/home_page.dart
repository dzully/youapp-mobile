import 'package:flutter/material.dart';

import 'components/about_edit_card.dart';
import 'components/interest_edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isEditingAbout = false;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late Animation<double> _fadeAnimation;
  List<String> _interests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF091418), // rgba(9, 20, 26, 1)
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Fixed Header
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '@johndoe123',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 32),
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 17,
                          ),
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 190),
                          decoration: BoxDecoration(
                            color: const Color(0xFF162329),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                '@johndoe123',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: isEditingAbout
                              ? AboutEditCard(
                                  key: const ValueKey('edit'),
                                  onSaveComplete: () {
                                    setState(() {
                                      isEditingAbout = false;
                                    });
                                    _animationController.reverse();
                                  },
                                )
                              : _buildProfileSection(
                                  key: const ValueKey('view'),
                                  title: 'About',
                                  subtitle:
                                      'Add in your your to help others know you better',
                                  onTap: () {
                                    setState(() {
                                      isEditingAbout = true;
                                    });
                                    _animationController.forward();
                                  },
                                ),
                        ),
                        const SizedBox(height: 18),
                        _buildProfileSection(
                          title: 'Interest',
                          subtitle:
                              'Add in your interest to find a better match',
                          onTap: () async {
                            final List<String>? updatedInterests =
                                await Navigator.push<List<String>>(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InterestEditPage()),
                            );

                            if (updatedInterests != null) {
                              // Handle the updated interests here
                              setState(() {
                                // Update your interests state variable
                                _interests = updatedInterests;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 18), // Add bottom padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
  }

  Widget _buildProfileSection({
    Key? key,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 120),
        decoration: BoxDecoration(
          color: const Color(0xFF0E191F),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.edit_outlined,
                  color: Colors.white.withOpacity(0.7),
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
