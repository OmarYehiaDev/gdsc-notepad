import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<bool> signInWithGogle(BuildContext context) async {
    bool isSignedIn = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // Sign in with credentials
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (kDebugMode) {
          print("User: $user");
        }

        if (user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            // Add user to Firestore
            await _firestore.collection('users').doc(user.uid).set({
              'name': user.displayName,
              'profilePhoto': user.photoURL,
              'uid': user.uid,
            });
          }
          isSignedIn = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      isSignedIn = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return isSignedIn;
  }
}
