import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String email;
  final String password;
  final String profilepic;
  final String adress;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.profilepic,
    required this.adress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'profilepic': profilepic,
      'adress': adress,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data();
    return UserModel(
      name: map?['name'] as String,
      email: map?['email'] as String,
      password: map?['password'] as String,
      profilepic: map?['profilepic'] as String,
      adress: map?['adress'] as String,
    );
  }
}
