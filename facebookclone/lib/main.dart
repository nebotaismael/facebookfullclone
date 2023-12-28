import 'package:facebookclone/features/authentication/controller/authcontroller.dart';
import 'package:facebookclone/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: FaceBook()));
}

class FaceBook extends ConsumerStatefulWidget {
  const FaceBook({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<FaceBook> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder(
            stream: ref.read(authapi).authState,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData && snapshot.data != null) {
                return Scaffold();
              }

              return Login();
            })),
      ),
    );
  }
}
