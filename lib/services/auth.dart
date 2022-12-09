import 'package:firebase_auth/firebase_auth.dart';
import "package:cpmdwithf_project/domain/user.dart";

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserOur?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return UserOur.fromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future<UserOur?> registerInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return UserOur.fromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<UserOur?> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User? user) => user != null ? UserOur.fromFirebase(user) : null);
  }
}
