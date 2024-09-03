import 'package:book_keeper/auth/presentation/pages/home_screen.dart';
import 'package:book_keeper/auth/presentation/pages/signup_screen.dart';
import 'package:book_keeper/auth/repository/auth_repository.dart';
import 'package:book_keeper/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessTokenAsyncValue = ref.watch(accessTokenProvider);
    final userAsyncValue = ref.watch(authStatusChangesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Book Keeper",
      theme: theme,
      home: accessTokenAsyncValue.when(
        data: (accessToken) {
          if (accessToken != null) {
            return const HomeScreen();
          } else {
            return userAsyncValue.when(
              data: (user) {
                if (user != null) {
                  return const HomeScreen();
                } else {
                  return const SignupScreen();
                }
              },
              loading: () => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stackTrace) => Scaffold(
                body: Center(
                  child: Text("Error: $error"),
                ),
              ),
            );
          }
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) => Scaffold(
          body: Center(
            child: Text("Error: $error"),
          ),
        ),
      ),
    );
  }
}
