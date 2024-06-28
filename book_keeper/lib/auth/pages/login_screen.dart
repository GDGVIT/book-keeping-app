import 'package:book_keeper/auth/controllers/login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginPageControllerProvider);
    ref.listen(loginPageControllerProvider, (_, state) {
      if (!state.isLoading && state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error.toString())),
        );
      } else if (!state.isLoading && state.hasValue) {
        Navigator.pop(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: state.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => ref.read(loginPageControllerProvider.notifier).signInWithGoogle(),
                child: const Text('Sign in with Google'),
              ),
      ),
    );
  }
}
