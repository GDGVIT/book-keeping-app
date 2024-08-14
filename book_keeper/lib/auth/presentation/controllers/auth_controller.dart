import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:book_keeper/auth/repository/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithGoogle() async {
    final authRepo = ref.read(authImplRepoProvider);
    await authRepo.signInWithGoogle();
  }

  Future<void> signOut() async {
    final authRepo = ref.read(authImplRepoProvider);
    await authRepo.signOut();
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final authRepo = ref.read(authImplRepoProvider);
    await authRepo.logInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final authRepo = ref.read(authImplRepoProvider);
    await authRepo.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
  }
}
