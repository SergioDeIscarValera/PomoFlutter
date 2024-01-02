import 'package:PomoFlutter/content/auth/errors/auth_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebaseRepository {
  Future<User> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthErrors.fromCode(e.code).message;
    } catch (e) {
      const ex = AuthErrors();
      throw ex.message;
    }
  }

  Future<User> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthErrors.fromCode(e.code).message;
    } catch (e) {
      const ex = AuthErrors();
      throw ex.message;
    }
  }

  Future<User> loginWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        return await FirebaseAuth.instance
            .signInWithPopup(googleProvider)
            .then((UserCredential userCredential) {
          User user = userCredential.user!;
          return user;
        });
      }

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((UserCredential userCredential) {
        User user = userCredential.user!;

        return user;
      });
    } on FirebaseAuthException catch (e) {
      throw AuthErrors.fromCode(e.code).message;
    } catch (e) {
      const ex = AuthErrors();
      throw ex.message;
    }
  }

  Future<void> passwordReset({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthErrors.fromCode(e.code).message;
    } catch (e) {
      const ex = AuthErrors();
      throw ex.message;
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AuthErrors.fromCode(e.code).message;
    } catch (e) {
      const ex = AuthErrors();
      throw ex.message;
    }
  }

  Future<void> removeUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        throw AuthErrors.fromCode(e.code).message;
      }
    } catch (e) {
      const ex = AuthErrors();
      throw ex.message;
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final providerData = firebaseAuth.currentUser?.providerData.first;

      if (GoogleAuthProvider().providerId == providerData!.providerId) {
        await firebaseAuth.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await firebaseAuth.currentUser?.delete();
    } catch (e) {
      const ex = AuthErrors();
      throw ex.message;
    }
  }
}
