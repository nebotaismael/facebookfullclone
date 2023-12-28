import 'package:facebookclone/features/authentication/controller/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to facebook clone \n Please click to authenticate with google',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () async {
                  await ref.read(authapi).signInWithGoogle(context);
                },
                child: const Text('Authenticate with Google'))
          ],
        )),
      ),
    );
  }
}
