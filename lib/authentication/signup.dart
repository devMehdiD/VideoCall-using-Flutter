import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:mettingscall/authentication/login.dart';
import 'package:provider/provider.dart';

import '../statemangment/statmangment.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
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
    final prov = Provider.of<StateManagment>(
      context,
    );
    return Scaffold(
      body: Stack(
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
                    child: Form(
                      key: prov.formKey,
                      child: ListView(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Full name',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Value';
                              }
                              return null;
                            },
                            controller: prov.username,
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
                            'Email Adress',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Value';
                              }
                              return null;
                            },
                            controller: prov.email,
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
                            'Phone number',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Value';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            controller: prov.phone,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Value';
                              }
                              return null;
                            },
                            obscureText: !vesibilty,
                            controller: prov.password,
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
                              prov.validateForm(context);
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
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
                                    onPressed: () {},
                                    icon: const CircleAvatar(
                                      child: Icon(
                                        Entypo.facebook,
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
                              'Already have an account ?',
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
                                    child: const Login(),
                                  );
                                }));
                              },
                              child: const Text(
                                'Log in',
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
                    ),
                  )))
        ],
      ),
    );
  }
}
