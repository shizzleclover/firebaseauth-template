import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ocr_take_2/Pages/SignIn.dart';
import 'package:ocr_take_2/Pages/homepage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?> (
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //User is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          //user is not logged in
          else {
            return LoginPage();
          }
        }
      )
    );
  }
}