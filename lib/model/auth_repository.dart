import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp({required String emailSignUp, required String passwordSignUp}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailSignUp, password: passwordSignUp);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'Mật khẩu yếu') {
        throw Exception('Mật khẩu được cung cấp quá yếu.');
      } else if (e.code == 'email đã được sử dụng') {
        throw Exception('Email đã được sử dụng để tạo tài khoản');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<void> signIn({required String emailSignIn, required String passwordSignIn}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailSignIn, password: passwordSignIn);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'Không tìm thấy ngừoi dùng') {
        throw Exception('Không tìm thấy người dùng nào cho email đó.');
      } else if (e.code == 'Sai mật khẩu') {
        throw Exception('Đã cung cấp sai mật khẩu cho người dùng đó.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<void>signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
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