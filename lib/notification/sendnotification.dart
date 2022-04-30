import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:mettingscall/statemangment/statmangment.dart';

sendNotification(StateManagment prov, drId, context) async {
  String serverKey =
      'AAAAasJXon4:APA91bFMprgZwNVMe7DF1STPaz8G6J_TTk6w7N3hP62-8GaQpMJ49poarC289xIaM-knBisOFGLdSYznLyucAh7VuZqJ5SAmVDpUL_CjX7xYBQjhg-Z2C9olfFfiOX2p7fvmCvrGLtBB';
  try {
    DocumentSnapshot<Map<String, dynamic>> driverDoucument =
        await FirebaseFirestore.instance.collection("users").doc(drId).get();

    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(<String, dynamic>{
        'notification': <String, dynamic>{
          'body': prov.phoneUser,
          'title': prov.nameUser,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'image': prov.imageUser,
          'status': 'v'
        },
        'to': driverDoucument['token'],
      }),
    );
  } catch (e) {
    print(e.toString());
  }
}

sendNotificationaudiocall(StateManagment prov, drId, context) async {
  String serverKey =
      'AAAAasJXon4:APA91bFMprgZwNVMe7DF1STPaz8G6J_TTk6w7N3hP62-8GaQpMJ49poarC289xIaM-knBisOFGLdSYznLyucAh7VuZqJ5SAmVDpUL_CjX7xYBQjhg-Z2C9olfFfiOX2p7fvmCvrGLtBB';
  try {
    DocumentSnapshot<Map<String, dynamic>> driverDoucument =
        await FirebaseFirestore.instance.collection("users").doc(drId).get();

    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(<String, dynamic>{
        'notification': <String, dynamic>{
          'body': prov.phoneUser,
          'title': prov.nameUser,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'image': prov.imageUser,
          'status': 'c'
        },
        'to': driverDoucument['token'],
      }),
    );
  } catch (e) {
    print(e.toString());
  }
}
