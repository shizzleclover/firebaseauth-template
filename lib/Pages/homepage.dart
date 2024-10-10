import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
    HomePage({super.key});

final user = FirebaseAuth.instance.currentUser!;
  //user signout
  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: _signUserOut, icon: Icon(Icons.logout))],),
      body: Center(child: Text('Logged in as${user.email!}'),),
    );
  }
}