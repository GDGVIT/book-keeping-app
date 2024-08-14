import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
part 'auth_repository.g.dart';

@riverpod
Stream<User?> authStatusChanges(AuthStatusChangesRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

final accessTokenProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
});

abstract class AuthRepo {
  User? currentUser();
  Future<void> signInWithGoogle();
  Future<void> signOut();
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

class AuthImplRepo implements AuthRepo {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  final baseUrl = dotenv.env['BASE_URL'];

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/users/login/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode >= 400) {
      print('Error response: ${response.body}');
      throw Exception('Failed to log in');
    } else if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', responseData['access_token']);
        prefs.setString('refresh_token', responseData['refresh_token']);
      } catch (e) {
        print('Error parsing response: ${response.body}');
        throw Exception('Failed to parse response');
      }
    } else {
      print('Unexpected response: ${response.body}');
      throw Exception('Unexpected response from server');
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/login/');
    print(url);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode >= 400) {
      print('Error response: ${response.body}');
      throw Exception('Failed to log in');
    } else if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', responseData['access_token']);
        prefs.setString('refresh_token', responseData['refresh_token']);
      } catch (e) {
        print('Error parsing response: ${response.body}');
        throw Exception('Failed to parse response');
      }
    } else {
      print('Unexpected response: ${response.body}');
      throw Exception('Unexpected response from server');
    }
  }
}

@riverpod
AuthRepo authImplRepo(AuthImplRepoRef ref) {
  return AuthImplRepo();
}
