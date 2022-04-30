import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mettingscall/authentication/firebasemethode/saveinfouser.dart';
import 'package:mettingscall/home/homepage.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:mettingscall/widget/showsnackbar.dart';

loginMethode(StateManagment prov, context) async {
  try {
    prov.setisloadingTotrue();
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: prov.emailLogin.text.trim(),
        password: prov.passwordLogin.text.trim());
    if (credential != null) {
      await updateUserInfoWhenLogin();
      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
        pageBuilder: (contetx, animation, secondanimation) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          final position = Tween<Offset>(begin: begin, end: end);
          return SlideTransition(
            position: position.animate(animation),
            child: const HomePage(),
          );
        },
      ), (route) => false);
    }
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      prov.setisloadingToFalse();
      show('No user found for that email.', context);
    } else if (e.code == 'wrong-password') {
      prov.setisloadingToFalse();
      show('Wrong password provided for that user.', context);
    }
  }
}
