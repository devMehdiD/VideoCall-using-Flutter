import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:mettingscall/splashscren/spalshscren.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
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
    final prov = Provider.of<StateManagment>(context, listen: true);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.2,
            width: size.height * 0.2,
            child: CircleAvatar(
              backgroundImage: NetworkImage(prov.imageUser),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.1,
                left: size.width * 0.1,
                right: size.width * 0.1),
            child: Container(
              height: size.height * 0.5,
              width: size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.grey[50],
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: prov.nameUser,
                              hintStyle: const TextStyle(color: Colors.black26),
                              filled: true,
                              enabled: false,
                              fillColor: Colors.grey.withOpacity(0.2),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: prov.emailUser,
                              hintStyle: TextStyle(color: Colors.black26),
                              filled: true,
                              enabled: false,
                              fillColor: Colors.grey.withOpacity(0.2),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: prov.phoneUser,
                              hintStyle: const TextStyle(color: Colors.black26),
                              filled: true,
                              enabled: false,
                              fillColor: Colors.grey.withOpacity(0.2),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.dark_mode),
                            ),
                            title: const Text(
                              'Ligth & Dark Mode',
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Switch(
                                value: prov.darkMode,
                                onChanged: (val) {
                                  prov.switchMode(val);
                                }),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.logout),
                          ),
                          title: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Icon(Icons.logout),
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, second) {
                              const begin = Offset(1, 0);
                              const end = Offset.zero;
                              final position =
                                  Tween<Offset>(begin: begin, end: end);
                              return SlideTransition(
                                position: position.animate(animation),
                                child: SplasScren(),
                              );
                            }), (route) => false);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
