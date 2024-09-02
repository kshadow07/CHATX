import 'package:chtx/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chtx/screens/contactpage.dart';

import 'package:flutter/material.dart';

class Auth_Gate extends StatefulWidget {
  const Auth_Gate({super.key});
  @override
  State<Auth_Gate> createState() => _Auth_GateState();
}

class _Auth_GateState extends State<Auth_Gate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: FirebaseAuth.instance.currentUser,
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return ContactPage();
          } else {
            return Login_Page();
          }
        },
      ),
    );
  }
}
