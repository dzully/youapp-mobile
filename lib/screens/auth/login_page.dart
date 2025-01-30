import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youapp/screens/auth/register_page.dart';

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

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(1.0, -0.3),
          radius: 1.2,
          colors: kLoginGradientColors,
          stops: kLoginGradientStops,
        ),
      ),
      child: child,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool get _isFormValid =>
      _emailError == null &&
      _passwordError == null &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    // Add TextEditingController listeners to trigger state updates
    _emailController.addListener(_updateFormState);
    _passwordController.addListener(_updateFormState);

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
                // Back Button
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

                // Login Title
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                // Username/Email TextField
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter Username/Email',
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
                    errorText: _emailError,
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
                  ),
                ),

                const SizedBox(height: 16),

                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: !isPasswordVisible,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
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
                    errorText: _passwordError,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                Container(
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
                            color: _isFormValid
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Register Link
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: RichText(
                      text: TextSpan(
                        text: 'No account? ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: 'Register here',
                            style: const TextStyle(
                              color: Color(0xFFD4AF37), // Gold/yellow color
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()),
                                );
                              },
                          ),
                        ],
                      ),
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
    _emailController.removeListener(_updateFormState);
    _passwordController.removeListener(_updateFormState);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Add new method to update form state
  void _updateFormState() {
    setState(() {
      // This empty setState will trigger a rebuild with updated _isFormValid
    });
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _validateInputs() {
    setState(() {
      // Validate email
      if (_emailController.text.isEmpty) {
        _emailError = 'Email is required';
      } else if (!_validateEmail(_emailController.text)) {
        _emailError = 'Invalid email format';
      } else {
        _emailError = null;
      }

      // Validate password
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password is required';
      } else {
        _passwordError = null;
      }
    });
  }
}
