import 'dart:async';

import 'package:dynamiclink/Firebasedynamic.dart';
import 'package:dynamiclink/Home.dart';
import 'package:dynamiclink/Loginuser.dart';
import 'package:dynamiclink/PageShow.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme:
      //     ThemeData(primarySwatch: Colors.yellow, brightness: Brightness.dark),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "";

  @override
  void initState() {
    initDynamicLinks();
    super.initState();
  }

  ///Retreive dynamic link firebase.
  void initDynamicLinks() async {
    print("ok");
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    print("Link +" + deepLink.toString());

    if (deepLink != null) {
      handleDynamicLink(deepLink);
    }
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      print("Link event :" + event.toString());
      final Uri? deepLink = event.link;

      // var data = event as Map;
      print(deepLink);
      handleDynamicLink(deepLink!);
    });
  }

  handleDynamicLink(Uri url) {
    print(url);
    List<String> separatedString = [];
    separatedString.addAll(url.path.split('?'));

    var isStory = url.pathSegments.contains('user');
    print(separatedString);
    print(isStory);

    if (isStory) {
      var id = url.queryParameters["id"];
      print(id);
    }

    Timer(
        Duration(seconds: 5),
        () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeApp()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Chat App"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp1()));
                  },
                  child: Text("Go to Login Page"))
            ],
            // mainAxisAlignment: MainAxisAlignment.center,
            // children: <Widget>[
            //     ElevatedButton(onPressed: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>PageShow()));

            //     }, child: Text("User account")),
            // ElevatedButton(
            //     onPressed: () async {
            //       try {
            //         url = await FirebaseDynamicLinkService.createDynamicLink(
            //             "user");
            //       } catch (e) {
            //         print(e);
            //       }
            //       setState(() {});
            //     },
            //     child: Text(
            //       "Generate Dynamic Link",
            //       style: TextStyle(fontSize: 20),
            //     )),
            // const SizedBox(
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
          ),
        ),
      ),
    );
  }
}
