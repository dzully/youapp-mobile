import 'package:flutter/material.dart';

class InterestEditPage extends StatefulWidget {
  const InterestEditPage({super.key});

  @override
  State<InterestEditPage> createState() => _InterestEditPageState();
}

class _InterestEditPageState extends State<InterestEditPage> {
  final List<String> _interests = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center:
                Alignment(1.0, -1.0), // Positions at top-right (100%, -3.39%)
            radius: 1.2, // Covers ~121% of the container
            colors: [
              Color(0xFF1F4247), // 0%
              Color(0xFF0D1D23), // 56.18%
              Color(0xFF09141A), // 100%
            ],
            stops: [0.0, 0.5618, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Back Button with Save
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        TextButton(
                          onPressed: () {
                            // Pass back the interests list when popping
                            Navigator.pop(context, _interests);
                          },
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment(-1.0, 0.0),
                                end: Alignment(1.0, 0.0),
                                colors: [
                                  Color(0xFFABFFFD), // 2.64%
                                  Color(0xFF4599DB), // 102.4%
                                  Color(0xFFAADAFF), // 102.4%
                                ],
                                stops: [0.0264, 1.024, 1.024],
                              ).createShader(bounds);
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors
                                    .white, // This color will be masked by the gradient
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    // Title Section
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment(-1.0, 0.0),
                          end: Alignment(1.0, 0.0),
                          colors: [
                            Color(0xFF94783E), // -6.8%
                            Color(0xFFF3EDA6), // 16.76%
                            Color(0xFFF8FAE5), // 30.5%
                            Color(0xFFFFE2BE), // 49.6%
                            Color(0xFFD5BE88), // 78.56%
                            Color(0xFFF8FAE5), // 89.01%
                            Color(0xFFD5BE88), // 100.43%
                          ],
                          stops: [
                            -0.068,
                            0.1676,
                            0.305,
                            0.496,
                            0.7856,
                            0.8901,
                            1.0043
                          ],
                        ).createShader(bounds);
                      },
                      child: const Text(
                        'Tell everyone about yourself',
                        style: TextStyle(
                          color: Colors
                              .white, // This will be masked by the gradient
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'What interest you?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 35),
                    // Interest Input Field
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF162329),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.start,
                        children: [
                          ...(_interests.map((interest) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: const BoxConstraints(
                                  minHeight: 31,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      interest,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => setState(
                                          () => _interests.remove(interest)),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                          IntrinsicWidth(
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(color: Colors.white),
                              onSubmitted: _addInterest,
                              decoration: InputDecoration(
                                hintText: _interests.isEmpty
                                    ? 'Add your interests'
                                    : '',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 12,
                                ),
                                constraints:
                                    BoxConstraints(minWidth: double.infinity),
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addInterest(String interest) {
    if (interest.trim().isNotEmpty && !_interests.contains(interest.trim())) {
      setState(() {
        _interests.add(interest.trim());
        _controller.clear();
      });
    }
  }
}
