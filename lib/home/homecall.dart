import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mettingscall/calls/appbraine.dart';
import 'package:mettingscall/calls/secondcall.dart';
import 'package:mettingscall/calls/videocall.dart';
import 'package:mettingscall/notification/fcm.dart';
import 'package:mettingscall/notification/sendnotification.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:provider/provider.dart';

import '../widget/showcaller.dart';

class HomeCall extends StatefulWidget {
  const HomeCall({Key? key}) : super(key: key);

  @override
  State<HomeCall> createState() => _HomeCallState();
}

class _HomeCallState extends State<HomeCall>
    with SingleTickerProviderStateMixin {
  var image;
  var number;
  var name;
  var status;
  late AnimationController _controller;
  final users = FirebaseFirestore.instance
      .collection('users')
      .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots(includeMetadataChanges: true);

  @override
  void initState() {
    Fcm fcm = Fcm();
    fcm.setNotificationSettings();
    fcm.bodyctrl.stream.listen((event) {
      name = event;
    });
    fcm.titlectrl.stream.listen((event) {
      number = event;
    });
    fcm.statuts.stream.listen((event) {
      setState(() {
        status = event;
      });
    });
    fcm.imagectrl.stream.listen((event) {
      image = event;
      if (status == 'v') {
        showDialog(
            context: context,
            builder: (context) => showCallerDailog(
                MediaQuery.of(context).size, name, number, image, context));
      } else {
        showDialog(
            context: context,
            builder: (context) => showCallerDailogAudio(
                MediaQuery.of(context).size, name, number, image, context));
      }
    });
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final prov = Provider.of<StateManagment>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: users,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          subtitle: Text(snapshot.data!.docs[i]['phone'] ??
                              'xxx xxx xxx xxx'),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data!.docs[i]['accountPicture'])),
                          title: Text(
                            snapshot.data!.docs[i]['name'],
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await sendNotification(prov,
                                        snapshot.data!.docs[i]['id'], context);
                                    await prov.generateToken(
                                        snapshot.data!.docs[i]['id'], context);
                                  },
                                  icon: const Icon(
                                    Icons.video_call,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    await sendNotificationaudiocall(prov,
                                        snapshot.data!.docs[i]['id'], context);
                                    prov.generateTokenforAudio(
                                        snapshot.data!.docs[i]['id'],
                                        context,
                                        snapshot.data!.docs[i]
                                            ['accountPicture'],
                                        snapshot.data!.docs[i]['phone'] ??
                                            'xxx xxx xxx xxx');
                                  },
                                  icon: const Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                  ))
                            ],
                          ),
                        ),
                        const Divider(
                          height: 2,
                          indent: 80,
                        )
                      ],
                    ),
                  );
                });
          }
          return Center(
              child: LoadingBouncingGrid.square(
            borderColor: Colors.cyan,
            borderSize: 3.0,
            size: 30.0,
            backgroundColor: Colors.cyanAccent,
            duration: const Duration(milliseconds: 500),
          ));
        },
      ),
    );
  }
}
