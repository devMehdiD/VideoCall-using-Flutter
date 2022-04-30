import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'appbraine.dart';

class AudioSecondCall extends StatefulWidget {
  AudioSecondCall({Key? key}) : super(key: key);

  @override
  State<AudioSecondCall> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<AudioSecondCall> {
  late RtcEngine _engine;
  int _remoteUid = 0;
  String image = '';
  String phone = '';
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
              image = element.data()['callimage'];
              phone = element.data()['callphone'];
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Column(
            children: [
              SizedBox(
                height: size.height * 0.3,
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(image),
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
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: CircleAvatar(
                      child: IconButton(
                          onPressed: () {
                            _engine.switchCamera();
                          },
                          icon: const Icon(
                            Icons.switch_camera,
                          )),
                    ),
                  ),
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
                                      .collection("calls")
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
        style: TextStyle(color: Colors.white),
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
