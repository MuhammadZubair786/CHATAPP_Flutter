import 'package:dynamiclink/Firebasedynamic.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController con = TextEditingController();
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();

  String url = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  DatabaseReference db = FirebaseDatabase.instance.ref('User');


  Future<void> signup() async {
    // await auth.createUserWithEmailAndPassword(
    //     email: con.text, password: con1.text);
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
       var user =  await auth.createUserWithEmailAndPassword(
            email: con.text, password: con1.text);

            await db.child(user.user!.uid).set({
              "Email":con.text,
              "Name":con2.text,
              "Passowrd":con1.text
            });

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

  Login() async {
    await auth.signInWithEmailAndPassword(email: con.text, password: con1.text);
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
                "Sign Up Page ",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
                Text("Name"),
              TextField(
                controller: con2,
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
                  child: Text("CREATE ACCOUNT")),

              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Signin Account"),
              )
              //    ElevatedButton(onPressed: (){
              //     signup();
              //   }, child: Text("LOGIN")),
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
