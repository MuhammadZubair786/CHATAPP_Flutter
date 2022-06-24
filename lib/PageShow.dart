// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PageShow extends StatefulWidget {

  @override
  State<PageShow> createState() => _PageShowState();
}

class _PageShowState extends State<PageShow> {      

  List _colors =[ Colors.red,Colors.pink,Colors.yellow];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView.builder(
          itemCount: _colors.length,
          itemBuilder: (context,index){
            return Container(
            color: _colors[index],
            child: Text("Page : "+index.toString()),

              
            );
          
          },
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          onPageChanged: (index){
            print(index);
          },
          ),
      ),
      
    );
  }
}