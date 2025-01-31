import 'package:get/get.dart';
import 'base_controller.dart';

class AuthController extends BaseController {
  final _isLoggedIn = false.obs;
  
  bool get isLoggedIn => _isLoggedIn.value;

  Future<void> login(String email, String password) async {
    try {
      setLoading(true);
      clearError();
      
      // Implement your login logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      _isLoggedIn.value = true;
      
      Get.offAllNamed('/home');
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> register(String email, String password) async {
    try {
      setLoading(true);
      clearError();
      
      // Implement your registration logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      _isLoggedIn.value = true;
      
      Get.offAllNamed('/home');
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void logout() {
    _isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}