import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'appbraine.dart';

class VideoCallScreen extends StatefulWidget {
  VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late RtcEngine _engine;
  int _remoteUid = 0;

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    final doc = FirebaseFirestore.instance
        .collection('ids')
        .where('ids',
            arrayContainsAny: [FirebaseAuth.instance.currentUser!.uid])
        .get()
        .then((value) {
          value.docs.forEach((element) {
            setState(() {
              AgoraManager.token = element.data()['token'];
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
            child: _renderRemoteVideo(),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: Container(
                      height: 150, width: 150, child: _renderLocalPreview()),
                ),
              ),
            ),
          ),
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
                              .collection('calls')
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

  Widget _renderLocalPreview() {
    return RtcLocalView.SurfaceView();
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: AgoraManager.channelName,
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
