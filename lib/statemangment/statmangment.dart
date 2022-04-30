import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mettingscall/calls/audiocall.dart';
import '../authentication/choseimage.dart';
import 'package:http/http.dart' as http;

import '../calls/appbraine.dart';
import '../calls/videocall.dart';

class StateManagment extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  bool isloadingcall = false;
  var imageUser =
      'https://firebasestorage.googleapis.com/v0/b/videocall-f418c.appspot.com/o/user.png?alt=media&token=4a091e87-d5d5-45b4-8d08-0a04bac2cc2f';
  var nameUser = 'name';
  var phoneUser = 'phone';
  var emailUser = 'email';
  String path = '';
  bool darkMode = false;
  String imageToStorage = '';
  dynamic url;
  bool isloading = false;
  ImageProvider image = const AssetImage('assets/user.png');

  final formKey = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  validateForm(context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.push(context,
          PageRouteBuilder(pageBuilder: (contetx, animation, secondanimation) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        final position = Tween<Offset>(begin: begin, end: end);
        return SlideTransition(
          position: position.animate(animation),
          child: const ChoseImage(),
        );
      }));
    }
  }

  validateFormLogin(context) {
    if (formKeyLogin.currentState!.validate()) {
      formKeyLogin.currentState!.save();
      return true;
    }
  }

  choseImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagepi = await _picker.pickImage(source: ImageSource.gallery);
    if (imagepi != null) {
      path = imagepi.path;
      url = File(imagepi.path);
      image = FileImage(url);
      notifyListeners();
    } else {
      print('null image');
    }
  }

  setisloadingTotrue() {
    isloading = true;
    notifyListeners();
  }

  setisloadingToFalse() {
    isloading = false;
    notifyListeners();
  }

  addImageInStorage() async {
    int random = Random(1000).nextInt(1000);
    final ref = FirebaseStorage.instance.ref('images/$random');
    ref.putFile(url);
    imageToStorage = await ref.getDownloadURL();
    print(imageToStorage);
    notifyListeners();
  }

  switchMode(value) {
    darkMode = value;
    notifyListeners();
  }

  getInfoCurrentUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      nameUser = event.get('name');
      phoneUser = event.get('phone') ?? 'xxx xxx xxx xxx';
      emailUser = event.get('email');
      imageUser = event.get('accountPicture') ??
          'https://firebasestorage.googleapis.com/v0/b/videocall-f418c.appspot.com/o/user.png?alt=media&token=4a091e87-d5d5-45b4-8d08-0a04bac2cc2f';
      notifyListeners();
    });
  }

  createCallDoucument(token, id, context) async {
    await FirebaseFirestore.instance.collection('calls').add({
      'token': token,
      'ids': [id, FirebaseAuth.instance.currentUser!.uid],
    });
    Navigator.push(context,
        PageRouteBuilder(pageBuilder: (contetx, animation, secondanimation) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      final position = Tween<Offset>(begin: begin, end: end);
      return SlideTransition(
        position: position.animate(animation),
        child: VideoCallScreen(),
      );
    }));
  }

  Future<void> generateToken(
    id,
    context,
  ) async {
    var urlresponse =
        'https://agora-node-tokenserver-1.mehdimido3.repl.co/access_token?channelName=${AgoraManager.channelName}';
    var response = await http.get(Uri.parse(urlresponse));
    var responsebody = jsonDecode(response.body);
    createCallDoucument(responsebody['token'], id, context);
    notifyListeners();
  }

  Future<void> generateTokenforAudio(
      id, context, callingimage, callingnumber) async {
    var urlresponse =
        'https://agora-node-tokenserver-1.mehdimido3.repl.co/access_token?channelName=${AgoraManager.channelName}';
    var response = await http.get(Uri.parse(urlresponse));
    var responsebody = jsonDecode(response.body);
    createCallDoucumentforAudio(
        responsebody['token'], id, context, callingimage, callingnumber);
    notifyListeners();
  }

  createCallDoucumentforAudio(
      token, id, context, callingimage, callingnumber) async {
    await FirebaseFirestore.instance.collection('audio').add({
      'callingphone': callingnumber,
      'callingimage': callingimage,
      'callimage': imageUser,
      'callphone': phoneUser,
      'token': token,
      'ids': [id, FirebaseAuth.instance.currentUser!.uid],
    });
    Navigator.push(context,
        PageRouteBuilder(pageBuilder: (contetx, animation, secondanimation) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      final position = Tween<Offset>(begin: begin, end: end);
      return SlideTransition(
        position: position.animate(animation),
        child: AudioCall(),
      );
    }));
  }
}
