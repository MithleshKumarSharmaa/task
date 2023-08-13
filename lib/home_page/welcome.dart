import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  final User user;

  const WelcomeScreen(this.user, {super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
        final displayName = userData['displayName'] ?? 'User';
        final email = userData['email'] ?? '';
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome, $displayName!'),
                Text('Email: $email'),
              ],
            ),
          ),
        );
      },
    );
  }
}
