import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:mettingscall/authentication/firebasemethode/saveinfouser.dart';
import 'package:mettingscall/home/homepage.dart';

Future<UserCredential> signInWithGitHub(BuildContext context) async {
  // Create a GitHubSignIn instance
  final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: '02a8d2ab3cdb357e58ef',
      clientSecret: '0f97d0a46cfeb288871bfbbfff5f3ee512165360',
      redirectUrl: 'https://videocall-f418c.firebaseapp.com/__/auth/handler');

  // Trigger the sign-in flow
  final GitHubSignInResult result = await gitHubSignIn.signIn(context);

  // Create a credential from the access token
  final githubAuthCredential = GithubAuthProvider.credential(result.token!);

  // Once signed in, return the UserCredential
  final cred =
      await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
  if (cred != null) {
    saveInfoUserIndataBase(
        cred.user!.uid,
        cred.user!.displayName,
        cred.user!.email,
        cred.user!.photoURL,
        cred.user!.phoneNumber,
        cred.user!.uid);
    Navigator.pushAndRemoveUntil(context,
        PageRouteBuilder(pageBuilder: (context, animation, second) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      final position = Tween<Offset>(begin: begin, end: end);
      return SlideTransition(
        position: position.animate(animation),
        child: const HomePage(),
      );
    }), (route) => false);
  }
  return cred;
}
