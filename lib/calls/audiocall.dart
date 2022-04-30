import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'appbraine.dart';

class AudioCall extends StatefulWidget {
  AudioCall({Key? key}) : super(key: key);

  @override
  State<AudioCall> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<AudioCall> {
  late RtcEngine _engine;
  int _remoteUid = 0;
  dynamic image;
  dynamic phone;
  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    final doc = FirebaseFirestore.instance
        .collection('audio')
        .where('ids',
            arrayContainsAny: [FirebaseAuth.instance.currentUser!.uid])
        .get()
        .then((value) {
          value.docs.forEach((element) {
            setState(() {
              AgoraManager.token = element.data()['token'];
              image = element.data()['callingimage'];
              phone = element.data()['callingphone'];
            });
          });
        });
    _engine = await RtcEngine.create(AgoraManager.appId);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {},
        userJoined: (int uid, int elapsed) {
          setState(() => _remoteUid = uid);
        },
        userOffline: (int uid, UserOfflineReason reason) {
          setState(() => _remoteUid = 0);
          Navigator.of(context).pop(true);
        },
      ),
    );
    await _engine.joinChannel(
        AgoraManager.token, AgoraManager.channelName, null, 0);
  }

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Column(
            children: [
              CircleAvatar(
                child: Image.network(image),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                phone,
                style: const TextStyle(color: Colors.black),
              )
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('audio')
                              .where('ids', arrayContainsAny: [
                                FirebaseAuth.instance.currentUser!.uid
                              ])
                              .get()
                              .then((value) {
                                value.docs.forEach((element) {
                                  FirebaseFirestore.instance
                                      .collection("audio")
                                      .doc(element.id)
                                      .delete()
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                });
                              });
                        },
                        icon: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return Text(
        'Calling with $_remoteUid',
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text(
        'Calling …',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      );
    }
  }
}
