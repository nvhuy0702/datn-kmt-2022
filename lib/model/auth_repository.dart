import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Mật khẩu được cung cấp quá yếu.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Tài khoản đã tồn tại cho email đó.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Không tìm thấy người dùng nào cho email đó.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Đã cung cấp sai mật khẩu cho người dùng đó.');
      }
    }
  }
  Future<void> resetPassword({
    required String emailReset,
  }) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailReset);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Không tìm thấy người dùng nào cho email đó.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Đã cung cấp sai mật khẩu cho người dùng đó.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}