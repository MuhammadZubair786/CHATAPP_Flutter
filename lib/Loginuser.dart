// ignore_for_file: prefer_const_constructors

import 'package:dynamiclink/Firebasedynamic.dart';
import 'package:dynamiclink/Signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class MyApp1 extends StatefulWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  TextEditingController con = TextEditingController();
  TextEditingController con1 = TextEditingController();
  String url = "";

  Future<void> signup() async {
    FirebaseAuth auth = await FirebaseAuth.instance;

    if (con.text == "" ||
        con.text == null && con1.text == null ||
        con1.text == "") {
      // ignore: prefer_const_constructors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Email And Password"),
      ));
    } else if (con.text == "" || con.text == null) {
      // ignore: prefer_const_constructors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Email Address"),
      ));
    } else if (con1.text == "" || con1.text == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Password"),
      ));
    } else {
      try {
        await auth.createUserWithEmailAndPassword(
            email: con.text, password: con1.text);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Success Fully Account Created"),
        ));
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
        ));
      }
    }
  }

  Login() async {
    FirebaseAuth auth = await FirebaseAuth.instance;

    if (con.text == "" ||
        con.text == null && con1.text == null ||
        con1.text == "") {
      // ignore: prefer_const_constructors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Email And Password"),
      ));
    } else if (con.text == "" || con.text == null) {
      // ignore: prefer_const_constructors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Email Address"),
      ));
    } else if (con1.text == "" || con1.text == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Password"),
      ));
    } else {
      try {
        await auth.createUserWithEmailAndPassword(
            email: con.text, password: con1.text);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Success Fully Login Account"),
        ));
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // ignore: prefer_const_constructors
              Text(
                "Login Page ",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              // ignore: prefer_const_constructors
              Text("Email"),
              TextField(
                controller: con,
              ),
              Text("Password"),
              TextField(
                controller: con1,
              ),

              ElevatedButton(
                  onPressed: () {
                    signup();
                  },
                  child: Text("LOGIN")),
              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signin()));
                },
                child: Text("Create Account "),
              )
              //   ElevatedButton(
              //     onPressed: () async {
              //       try {
              //         url = await FirebaseDynamicLinkService.createDynamicLink(
              //             FirebaseAuth.instance.currentUser!.uid);
              //       } catch (e) {
              //         print(e);
              //       }
              //       setState(() {});
              //     },
              //     child: Text(
              //       "Generate Dynamic Link",
              //       style: TextStyle(fontSize: 20),
              //     )),
              //     const SizedBox(
              //   height: 20,
              // ),
              // if (url.isNotEmpty)
              //   Center(
              //     child: RichText(
              //         text: TextSpan(children: [
              //       TextSpan(text: url, style: TextStyle(fontSize: 20)),
              //       WidgetSpan(
              //           child: IconButton(
              //               onPressed: () {
              //                 Clipboard.setData(ClipboardData(text: url));
              //               },
              //               icon: Icon(Icons.copy))),
              //     ])),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
