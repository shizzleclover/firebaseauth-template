import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // User Sign-in method
  void _signUserEmail() async {
    // UX Good practices: Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found');
      } else if (e.code == 'wrong-password') {
        print('Wrong Password');
      }
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          const SizedBox(height: 100, width: 100),
          Center(
            child: Column(
              children: [
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 15),
                Text(
                  'Welcome back User',
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          // Start Textfields
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                SizedBox(
                  width: 350, // Adjust the width here
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: GoogleFonts.montserrat(),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    controller: _usernameController,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 350, // Adjust the width here
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: GoogleFonts.montserrat(),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 300,
            child: Text("Forgot Password"),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 50,
            width: 350,
            child: ElevatedButton(
              onPressed: _signUserEmail,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5.0,
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
