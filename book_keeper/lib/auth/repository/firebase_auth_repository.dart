import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_auth_repository.g.dart';

@riverpod
Stream<User?> authStatusChanges(AuthStatusChangesRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

abstract class FireAuthRepo {
  User? currentUser();
  Future<void> signInWithGoogle();
  Future<void> signOut();
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
