import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:mettingscall/authentication/firebasemethode/loginmethode.dart';
import 'package:mettingscall/authentication/signup.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:provider/provider.dart';

import 'firebasemethode/loginwithgithub.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool vesibilty = false;
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
    final Size s = MediaQuery.of(context).size;
    final prov = Provider.of<StateManagment>(context);
    return Scaffold(
      body: Form(
        key: prov.formKeyLogin,
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.blueAccent.shade400,
              ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
            )),
            Positioned(
              top: s.height * 0.06,
              left: s.height * 0.03,
              child: Container(
                height: s.height * 0.05,
                width: s.height * 0.05,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    color: Color(0xfff1c232)),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
            ),
            Positioned(
                top: s.height * 0.11,
                left: 0,
                right: 0,
                height: s.height * 0.15,
                child: Image.asset('assets/video-camera.png')),
            Positioned(
                top: s.height * 0.3,
                width: s.width,
                height: s.height,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      child: ListView(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Email Adress',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            controller: prov.emailLogin,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Password',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            obscureText: vesibilty,
                            controller: prov.passwordLogin,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        vesibilty = !vesibilty;
                                      });
                                    },
                                    icon: vesibilty
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Colors.black,
                                          )),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        SizedBox(
                          height: s.height * 0.08,
                          width: s.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xfff1c232))),
                            onPressed: () {
                              if (prov.validateFormLogin(context)) {
                                loginMethode(prov, context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                prov.isloading
                                    ? const CircularProgressIndicator()
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        const Center(
                          child: Text(
                            'Or',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: s.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: s.height * 0.07,
                              width: s.height * 0.07,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                color: Colors.grey.withOpacity(0.2),
                                child: IconButton(
                                    onPressed: () {
                                      signInWithGitHub(context);
                                    },
                                    icon: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Entypo.github,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: s.height * 0.07,
                              width: s.height * 0.07,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                color: Colors.grey.withOpacity(0.2),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Entypo.gplus,
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Dont \' have an account ?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder:
                                        (contetx, animation, secondanimation) {
                                  const begin = Offset(1, 0);
                                  const end = Offset.zero;
                                  final position =
                                      Tween<Offset>(begin: begin, end: end);
                                  return SlideTransition(
                                    position: position.animate(animation),
                                    child: const SignUp(),
                                  );
                                }));
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color(0xfff1c232),
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 400,
                        )
                      ]),
                    )))
          ],
        ),
      ),
    );
  }
}
