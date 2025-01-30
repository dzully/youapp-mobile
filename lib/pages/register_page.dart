import 'package:flutter/material.dart';
import 'package:youapp/pages/login_page.dart';

const kLoginGradient = RadialGradient(
  center: Alignment(1.0, -0.3),
  radius: 1.2,
  colors: kLoginGradientColors,
  stops: kLoginGradientStops,
);

const kLoginGradientColors = [
  Color(0xFF1F4247), // Dark teal
  Color(0xFF0D1D23), // Dark blue-gray
  Color(0xFF09141A), // Nearly black
];

const kLoginGradientStops = [0.0, 0.5618, 1.0];

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _emailError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool get _isFormValid =>
      _emailError == null &&
      _usernameError == null &&
      _passwordError == null &&
      _confirmPasswordError == null &&
      _emailController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    _emailController.addListener(_updateFormState);
    _usernameController.addListener(_updateFormState);
    _passwordController.addListener(_updateFormState);
    _confirmPasswordController.addListener(_updateFormState);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kLoginGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'Enter Email',
                  errorText: _emailError,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _usernameController,
                  hintText: 'Create Username',
                  errorText: _usernameError,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Enter Password',
                  errorText: _passwordError,
                  isPassword: true,
                  isPasswordVisible: isPasswordVisible,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  errorText: _confirmPasswordError,
                  isPassword: true,
                  isPasswordVisible: isConfirmPasswordVisible,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildRegisterButton(),
                const Spacer(),
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateFormState);
    _usernameController.removeListener(_updateFormState);
    _passwordController.removeListener(_updateFormState);
    _confirmPasswordController.removeListener(_updateFormState);
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildLoginLink() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
          child: RichText(
            text: TextSpan(
              text: 'Have an account? ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              children: const [
                TextSpan(
                  text: 'Login here',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: _isFormValid
            ? [
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
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: _isFormValid ? _validateInputs : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _isFormValid
                    ? const Color(0xFF62CDCB)
                    : const Color(0xFF62CDCB).withOpacity(0.3),
                _isFormValid
                    ? const Color(0xFF4599DB)
                    : const Color(0xFF4599DB).withOpacity(0.3),
              ],
              begin: const Alignment(-0.3, 0.0),
              end: const Alignment(1.0, 0.0),
              stops: const [0.2488, 0.7849],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            height: 56,
            alignment: Alignment.center,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color:
                    _isFormValid ? Colors.white : Colors.white.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              child: const Text('Register'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    bool isPassword = false,
    bool? isPasswordVisible,
    VoidCallback? onTogglePasswordVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !(isPasswordVisible ?? false),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
        errorText: errorText,
        errorStyle: const TextStyle(
          color: Color(0xFFFF3B30),
          fontSize: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFFF3B30),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFFF3B30),
            width: 1,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ?? false
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.white.withOpacity(0.5),
                ),
                onPressed: onTogglePasswordVisibility,
              )
            : null,
      ),
    );
  }

  void _updateFormState() {
    setState(() {});
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _validateInputs() {
    setState(() {
      if (_emailController.text.isEmpty) {
        _emailError = 'Email is required';
      } else if (!_validateEmail(_emailController.text)) {
        _emailError = 'Invalid email format';
      } else {
        _emailError = null;
      }

      if (_usernameController.text.isEmpty) {
        _usernameError = 'Username is required';
      } else if (_usernameController.text.length < 3) {
        _usernameError = 'Username must be at least 3 characters';
      } else {
        _usernameError = null;
      }

      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password is required';
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
      } else {
        _passwordError = null;
      }

      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Please confirm your password';
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });
  }
}
