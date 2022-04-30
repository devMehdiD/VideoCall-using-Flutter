import 'package:flutter/material.dart';
import 'package:mettingscall/authentication/login.dart';
import '../authentication/signup.dart';

class SplasScren extends StatefulWidget {
  @override
  State<SplasScren> createState() => _SplasScrenState();
}

class _SplasScrenState extends State<SplasScren>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(2, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceIn,
  ));
  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.blueAccent,
          Colors.blueAccent.shade400,
        ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
        child: SlideTransition(
          position: _offsetAnimation,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              Text(
                'Let\'s get started!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: size.width * 0.08),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              Image.asset(
                'assets/video-camera.png',
                height: size.height * 0.24,
                width: size.height * 0.24,
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: size.height * 0.08,
                  width: size.width,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xfff1c232))),
                      onPressed: () {
                        Navigator.push(context, PageRouteBuilder(
                            pageBuilder: (contetx, animation, secondanimation) {
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
                            color: Colors.black, fontWeight: FontWeight.w700),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, PageRouteBuilder(
                          pageBuilder: (contetx, animation, secondanimation) {
                        const begin = Offset(1, 0);
                        const end = Offset.zero;
                        final position = Tween<Offset>(begin: begin, end: end);
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
              )
            ],
          ),
        ),
      ),
    )));
  }
}
