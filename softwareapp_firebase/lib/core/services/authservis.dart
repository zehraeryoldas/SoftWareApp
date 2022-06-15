import 'package:firebase_auth/firebase_auth.dart';

class AuthServis {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signIn(String userName, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: userName, password: password);

    return user.user;
  }
}
