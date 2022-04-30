import 'package:flutter/material.dart';
import 'package:mettingscall/calls/secondaudiocall.dart';
import 'package:mettingscall/calls/secondcall.dart';

Widget showCallerDailog(Size size, name, number, image, context) {
  return Material(
    child: Container(
      color: Colors.blue,
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          CircleAvatar(
            radius: size.height * 0.1,
            backgroundImage: NetworkImage(image),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03),
            ),
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.phone,
                      size: size.height * 0.05,
                    ),
                    color: Colors.red,
                  ),
                  const Text('Desline')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SecondCall()),
                      );
                    },
                    icon: Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: size.height * 0.05,
                    ),
                  ),
                  const Text('Answer')
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget showCallerDailogAudio(Size size, name, number, image, context) {
  return Material(
    child: Container(
      color: Colors.blue,
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          CircleAvatar(
            radius: size.height * 0.1,
            backgroundImage: NetworkImage(image),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03),
            ),
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.phone,
                      size: size.height * 0.05,
                    ),
                    color: Colors.red,
                  ),
                  const Text('Desline')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AudioSecondCall()),
                      );
                    },
                    icon: Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: size.height * 0.05,
                    ),
                  ),
                  const Text('Answer')
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
