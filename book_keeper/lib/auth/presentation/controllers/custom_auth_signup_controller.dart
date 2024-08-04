import 'package:book_keeper/auth/repository/custom_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_auth_signup_controller.g.dart';

@riverpod
class CustomAuthLoginController extends _$CustomAuthLoginController {
  @override
  Future<void> build() async {}

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final authRepo = ref.read(customAuthRepoProvider);
    await authRepo.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
  }
}
