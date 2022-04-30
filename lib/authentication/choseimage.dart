import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:provider/provider.dart';

import 'firebasemethode/signupwithemail.dart';

class ChoseImage extends StatefulWidget {
  const ChoseImage({Key? key}) : super(key: key);

  @override
  State<ChoseImage> createState() => _ChoseImageState();
}

class _ChoseImageState extends State<ChoseImage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prov = Provider.of<StateManagment>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.3),
              radius: size.height * 0.1,
              backgroundImage: prov.image,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
            child: GestureDetector(
              onTap: () {
                prov.choseImage();
              },
              child: Container(
                height: size.height * 0.07,
                width: size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 0.3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Entypo.attach,
                      color: Colors.red,
                    ),
                    Text(
                      'Chose Image ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.35,
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                '''Pleaz Chose Image To Continue Sign Up 
Wich  You can View The account Picture in Profile
''',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: size.height * 0.08,
              width: size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xfff1c232))),
                onPressed: () {
                  ceateAccountWithEmail(prov, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign UP',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    prov.isloading
                        ? const CircularProgressIndicator()
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
