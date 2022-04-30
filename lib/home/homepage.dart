import 'package:flutter/material.dart';

import 'package:mettingscall/home/settings.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:provider/provider.dart';
import 'homecall.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var _openResult;
  int index = 0;
  selctedpage() {
    switch (index) {
      case 0:
        return const HomeCall();

      case 1:
        return const SettingsPage();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      StateManagment stateManagment =
          Provider.of<StateManagment>(context, listen: false);
      await stateManagment.getInfoCurrentUser();
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
    final size = MediaQuery.of(context).size;
    final prov = Provider.of<StateManagment>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Video Call',
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: selctedpage(),
        bottomSheet: Padding(
          padding: EdgeInsets.only(
              bottom: size.height * 0.02,
              left: size.width * 0.07,
              right: size.width * 0.07),
          child: Container(
            height: size.height * 0.08,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_call,
                          color: index == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          size: index == 0 ? 29 : 25,
                        ),
                        Text(
                          'Video Call',
                          style: TextStyle(
                              color: index == 0
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              fontSize: index == 0 ? 16 : 14,
                              fontWeight: index == 0
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: index == 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                              color: index == 1
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              fontSize: index == 1 ? 16 : 14,
                              fontWeight: index == 1
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
