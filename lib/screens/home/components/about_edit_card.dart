import 'package:flutter/material.dart';

class AboutEditCard extends StatefulWidget {
  final VoidCallback onSaveComplete;

  const AboutEditCard({
    super.key,
    required this.onSaveComplete,
  });

  @override
  State<AboutEditCard> createState() => _AboutEditCardState();
}

class _AboutEditCardState extends State<AboutEditCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isGenderDropdownOpen = false;
  String _selectedGender = '';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
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
              const Text(
                'About',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Here you would typically save the data
                  // After saving is complete, call the callback
                  widget.onSaveComplete();
                },
                child: const Text(
                  'Save & Update',
                  style: TextStyle(
                    color: Color(0xFFCBFB5E),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF162329),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment(-0.96, 0.0),
                        end: Alignment(1.0, 0.0),
                        colors: [
                          Color(0xFF94783E),
                          Color(0xFFF3EDA6),
                          Color(0xFFF8FAE5),
                          Color(0xFFFFE2BE),
                          Color(0xFFD5BE88),
                          Color(0xFFF8FAE5),
                          Color(0xFFD5BE88),
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
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Add image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildProfileField(
            label: 'Display name:',
            placeholder: 'Enter name',
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Gender:',
            placeholder: 'Select Gender',
            isDropdown: true,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Birthday:',
            placeholder: 'DD MM YYYY',
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Horoscope:',
            placeholder: '--',
            enabled: false,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Zodiac:',
            placeholder: '--',
            enabled: false,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Height:',
            placeholder: 'Add height',
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Weight:',
            placeholder: 'Add weight',
          ),
        ],
      ),
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
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  Widget _buildGenderOption(String gender) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = gender;
          _isGenderDropdownOpen = false;
          _controller.reverse();
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          gender,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required String placeholder,
    bool isDropdown = false,
    bool enabled = true,
  }) {
    if (label == 'Gender:') {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isGenderDropdownOpen = !_isGenderDropdownOpen;
                if (_isGenderDropdownOpen) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF162329),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _selectedGender.isEmpty
                                ? placeholder
                                : _selectedGender,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white.withOpacity(
                                  _selectedGender.isEmpty ? 0.5 : 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: _isGenderDropdownOpen ? 0.5 : 0,
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
              margin: const EdgeInsets.only(left: 120, top: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF162329),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildGenderOption('Male'),
                  const Divider(height: 1, color: Color(0xFF0E191F)),
                  _buildGenderOption('Female'),
                ],
              ),
            ),
          ),
        ],
      );
    }
    if (label == 'Birthday:') {
      return Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: enabled ? _showDatePicker : null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF162329),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day.toString().padLeft(2, '0')} ${_selectedDate!.month.toString().padLeft(2, '0')} ${_selectedDate!.year}'
                      : placeholder,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(_selectedDate != null ? 1 : 0.5),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF162329),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    placeholder,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white.withOpacity(enabled ? 0.5 : 0.3),
                      fontSize: 14,
                    ),
                  ),
                ),
                if (isDropdown)
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFCBFB5E),
              surface: Color(0xFF162329),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF0E191F),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
