import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:book_keeper/auth/repository/auth_repo.dart';

part 'login_page_controller.g.dart';

@riverpod
class LoginPageController extends _$LoginPageController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithGoogle() async {
    final authRepo = ref.read(firebaseAuthRepoProvider);
    await authRepo.signInWithGoogle();
  }
}
