
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'custom_auth_repository.g.dart';

abstract class CustomAuth {
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
}

class CustomAuthRepo implements CustomAuth {
  final baseUrl = dotenv.env['BASE_URL'];
  
  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode >= 400) {
      throw Exception(responseData['message']);
    } else if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', responseData['access_token']);
      prefs.setString('refresh_token', responseData['refresh_token']);
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/signup');
    final response = await http.post(
      url,
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode >= 400) {
      throw Exception(responseData['message']);
    } else if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', responseData['access_token']);
      prefs.setString('refresh_token', responseData['refresh_token']);
    }
  }
}

@riverpod
CustomAuth customAuthRepo(CustomAuthRepoRef ref) {
  return CustomAuthRepo();
}