import 'dart:async';

import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AgriColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Image.asset('assets/images/logo.jpg'
            ,width: 200,height: 200,),
          SizedBox(height: 10,),
          Text("Agri Hub",style: TextStyle(fontSize: 20),)
        ],)
      ),
    );
  }
}
