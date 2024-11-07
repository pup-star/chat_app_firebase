import 'dart:developer';

import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app/ui/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong!"));
        }

        if (user == null) {
          log("User logged out");
          return const LoginScreen();
        } else {
          log("User logged in");
          userProvider.loadUser(user.uid);
          return BottomNavigationScreen();
        }
      },
    );
  }
}
