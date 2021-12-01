import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService{
  FirebaseAuth auth = FirebaseAuth.instance;

  // E-mail and Password Sign-In
  girisYap(String email,password) async {
    try {
      UserCredential userCredential = await auth


      
          .signInWithEmailAndPassword(
              email: email,
              password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
