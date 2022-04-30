import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mettingscall/authentication/token.dart';

saveInfoUserIndataBase(uid, name, email, accountPicture, phone, id) async {
  FirebaseFirestore.instance.collection('users').doc(uid).set({
    'name': name,
    'email': email,
    'accountPicture': accountPicture,
    'phone': phone,
    'id': id,
    'token': await getToken()
  });
}

updateUserInfoWhenLogin() async {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'token': await getToken()});
}
