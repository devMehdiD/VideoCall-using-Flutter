import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mettingscall/authentication/firebasemethode/saveinfouser.dart';
import 'package:mettingscall/home/homepage.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:mettingscall/widget/showsnackbar.dart';

ceateAccountWithEmail(StateManagment prov, context) async {
  try {
    prov.setisloadingTotrue();
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: prov.email.text.trim(),
      password: prov.password.text.trim(),
    );
    print('is here');
    if (credential != null) {
      await prov.addImageInStorage();
      saveInfoUserIndataBase(
          credential.user!.uid,
          prov.username.text.trim(),
          prov.email.text.trim(),
          prov.imageToStorage,
          prov.phone.text.trim(),
          credential.user!.uid);
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
    } else {
      show('erroo', context);
    }
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      prov.setisloadingToFalse();
      show('The password provided is too weak', context);
    } else if (e.code == 'email-already-in-use') {
      prov.setisloadingToFalse();
      show('The account already exists for that email', context);
    }
  } catch (e) {
    prov.setisloadingToFalse();
    print(e);
  }
}
