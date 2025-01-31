import 'package:flutter/material.dart';
import 'package:youapp/screens/auth/login_page.dart';
import 'package:youapp/screens/welcome/welcome_page.dart';

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

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const WelcomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
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
      ],
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
          child: RichText(
            text: const TextSpan(
              text: 'Have an account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              children: [
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
}

class _RegisterButton extends StatelessWidget {
  final bool isFormValid;
  final VoidCallback? onPressed;

  const _RegisterButton({required this.isFormValid, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: isFormValid
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
        onPressed: isFormValid ? onPressed : null,
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
                isFormValid
                    ? const Color(0xFF62CDCB)
                    : const Color(0xFF62CDCB).withOpacity(0.3),
                isFormValid
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
                    isFormValid ? Colors.white : Colors.white.withOpacity(0.5),
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
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _formControllers = {
    'email': TextEditingController(),
    'username': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };

  final _formErrors = <String, String?>{
    'email': null,
    'username': null,
    'password': null,
    'confirmPassword': null,
  };

  bool get _isFormValid =>
      _formErrors.values.every((error) => error == null) &&
      _formControllers.values
          .every((controller) => controller.text.isNotEmpty) &&
      _formControllers['password']!.text ==
          _formControllers['confirmPassword']!.text &&
      _validateEmail(_formControllers['email']!.text);

  @override
  Widget build(BuildContext context) {
    for (var controller in _formControllers.values) {
      controller.addListener(_updateFormState);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kLoginGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BackButton(),
                const SizedBox(height: 32),
                const _RegisterTitle(),
                const SizedBox(height: 32),
                ..._buildFormFields(),
                const SizedBox(height: 24),
                _RegisterButton(
                    isFormValid: _isFormValid, onPressed: _validateInputs),
                const Spacer(),
                const _LoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _formControllers.values) {
      controller.removeListener(_updateFormState);
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(
        controller: _formControllers['email']!,
        hintText: 'Enter Email',
        errorText: _formErrors['email'],
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _formControllers['username']!,
        hintText: 'Create Username',
        errorText: _formErrors['username'],
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _formControllers['password']!,
        hintText: 'Enter Password',
        errorText: _formErrors['password'],
        isPassword: true,
        isPasswordVisible: _isPasswordVisible,
        onTogglePasswordVisibility: () =>
            setState(() => _isPasswordVisible = !_isPasswordVisible),
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: _formControllers['confirmPassword']!,
        hintText: 'Confirm Password',
        errorText: _formErrors['confirmPassword'],
        isPassword: true,
        isPasswordVisible: _isConfirmPasswordVisible,
        onTogglePasswordVisibility: () => setState(
            () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
      ),
    ];
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

  String? _validateConfirmPasswordField() {
    final confirmPassword = _formControllers['confirmPassword']!.text;
    if (confirmPassword.isEmpty) return 'Please confirm your password';
    if (confirmPassword != _formControllers['password']!.text)
      return 'Passwords do not match';
    return null;
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegex.hasMatch(email);
  }

  String? _validateEmailField() {
    final email = _formControllers['email']!.text;
    if (email.isEmpty) return 'Email is required';
    if (!_validateEmail(email)) return 'Invalid email format';
    return null;
  }

  void _validateInputs() {
    setState(() {
      _formErrors['email'] = _validateEmailField();
      _formErrors['username'] = _validateUsernameField();
      _formErrors['password'] = _validatePasswordField();
      _formErrors['confirmPassword'] = _validateConfirmPasswordField();
    });
  }

  String? _validatePasswordField() {
    final password = _formControllers['password']!.text;
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateUsernameField() {
    final username = _formControllers['username']!.text;
    if (username.isEmpty) return 'Username is required';
    if (username.length < 3) return 'Username must be at least 3 characters';
    return null;
  }
}

class _RegisterTitle extends StatelessWidget {
  const _RegisterTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Register',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
