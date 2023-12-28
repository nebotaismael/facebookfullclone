// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authserviceprovider = Provider<AuthService>((ref) {
  return AuthService(
      ref: ref,
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance);
});

class AuthService {
  final ProviderRef ref;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  AuthService({
    required this.ref,
    required this.firestore,
    required this.auth,
  });

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
            'email': user.email,
            'phoneNumber': user.phoneNumber
          });
        }
        res = true;

        showsnackbar(context, 'Successfully gained access');
      }
    } on FirebaseAuthException catch (e) {
      showsnackbar(context, e.message!);
      res = false;
    }
    return res;
  }
}
