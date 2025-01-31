import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../core/errors/failures.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String username);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://api.youapp.com/v1', // Replace with your actual API URL
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerFailure('Login failed');
    }
  }

  @override
  Future<UserModel> register(String email, String password, String username) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/register'),
      body: {
        'email': email,
        'password': password,
        'username': username,
      },
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerFailure('Registration failed');
    }
  }

  @override
  Future<void> logout() async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/logout'),
    );

    if (response.statusCode != 200) {
      throw ServerFailure('Logout failed');
    }
  }
}