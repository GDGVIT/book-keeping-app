import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:book_keeper/auth/repository/firebase_auth_repository.dart';

part 'google_auth_controller.g.dart';

@riverpod
class GoogleAuthController extends _$GoogleAuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithGoogle() async {
    final authRepo = ref.read(firebaseAuthRepoProvider);
    await authRepo.signInWithGoogle();
  }
}
