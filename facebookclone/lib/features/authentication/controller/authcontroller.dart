// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebookclone/features/authentication/model/usermodel.dart';
import 'package:facebookclone/features/authentication/service/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authapi = Provider<AuthServiceController>((ref) {
  final AuthService authservice = ref.read(authserviceprovider);
  return AuthServiceController(ref: ref, authservice: authservice);
});

class AuthServiceController {
  ProviderRef ref;
  AuthService authservice;
  AuthServiceController({
    required this.ref,
    required this.authservice,
  });

  Future<bool> signInWithGoogle(BuildContext context) async {
    return authservice.signInWithGoogle(context);
  }

  Stream<User?> get authState => authservice.authState;

  User? get user => authservice.user;
  Stream<List<UserModel>> getAllUsers() {
    return authservice.getAllUsers();
  }

  Future<UserModel> userinfo(String uid) async {
    return authservice.userinfo(uid);
  }

  Future<void> signout() {
    return authservice.signout();
  }
}
