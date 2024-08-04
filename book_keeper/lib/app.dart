import 'package:book_keeper/auth/presentation/pages/home_screen.dart';
import 'package:book_keeper/auth/presentation/pages/login_screen.dart';
import 'package:book_keeper/auth/repository/auth_repo.dart';
import 'package:book_keeper/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStatusChangesProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Book Keeper",
      theme: theme,
      home: user.when(
        data: (user) {
          if (user != null) {
            return HomeScreen();
          } else {
            return const LoginScreen();
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
