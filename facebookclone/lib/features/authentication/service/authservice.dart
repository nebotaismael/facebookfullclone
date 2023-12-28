// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookclone/features/authentication/model/usermodel.dart';
import 'package:facebookclone/features/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Stream<User?> get authState => auth.authStateChanges();
  User? get user => auth.currentUser;

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
          final UserModel newuser = UserModel(
              id: user.uid,
              name: user.displayName!,
              email: user.email!,
              password: user.uid,
              profilepic: user.photoURL!,
              adress: user.phoneNumber!);
          await firestore
              .collection('users')
              .doc(user.uid)
              .set(newuser.toMap());
        }
        res = true;

        showsnackBar(context, 'Succesful');
      }
    } on FirebaseAuthException catch (e) {
      showsnackBar(context, e.message!);
      res = false;
    }
    return res;
  }

  Stream<List<UserModel>> getAllUsers() {
    return firestore.collection('users').snapshots().map((event) {
      return event.docs
          .map((DocumentSnapshot<Map<String, dynamic>> e) =>
              UserModel.fromMap(e))
          .toList();
    });
  }

  Future<UserModel> userinfo(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(snapshot);
  }

  Future<void> signout() {
    return auth.signOut();
  }
}
