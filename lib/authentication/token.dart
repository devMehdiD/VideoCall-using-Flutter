import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

getToken() async {
  return await FirebaseMessaging.instance.getToken();
}