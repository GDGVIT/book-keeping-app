import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
part 'auth_repo.g.dart';

@riverpod
Stream<User?> authStatusChanges(AuthStatusChangesRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

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
  // Future<void> refreshAccessToken();
  // Future<void> getUser();
}

abstract class FireAuthRepo {
  User? currentUser();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}

class CustomAuthRepo implements CustomAuth {
  // @override
  // Future<void> getUser() {
  //   throw UnimplementedError();
  // }
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

  // @override
// Future<void> refreshAccessToken() {
// throw UnimplementedError();
// }

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

class FirebaseAuthRepo implements FireAuthRepo {
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
}

@riverpod
FireAuthRepo firebaseAuthRepo(FirebaseAuthRepoRef ref) {
  return FirebaseAuthRepo();
}
