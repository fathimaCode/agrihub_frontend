import 'dart:convert';

import 'package:agrihub/controller/AuthenticationController.dart';
import 'package:agrihub/model/User.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constant/agri_color.dart';
import 'Login.dart';
class FarmerRegister extends StatelessWidget {
  FarmerRegister({super.key});
  final AuthenticationController _userController =
      Get.put(AuthenticationController());

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: AgriColors.screenHeight(context),
          width: AgriColors.screenWidth(context),
          decoration: BoxDecoration(color: AgriColors.primaryColor),
          child: Column(children: [
            SizedBox(height: 65), // Added SizedBox for spacing
            Text(
              "Welcome Farmer",
              style: TextStyle(fontSize: 25, color: AgriColors.whiteColor),
            ),
            Text(
              "Create an new account !",
              style: TextStyle(fontSize: 16, color: AgriColors.whiteColor),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Container(
              
                height: AgriColors.screenHeight(context)/1.5,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AgriColors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AgriColors.whiteColor, style: BorderStyle.solid, width: 1)),
                child: Column(
              
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: userNameController,
                        decoration: InputDecoration(labelText: "Username",border: OutlineInputBorder()),),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email Address",border: OutlineInputBorder()),),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
              
                            labelText: "Password",
                            border: OutlineInputBorder()),),
                    ),
                    Container(

                      margin: EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: contactController,
                        decoration: InputDecoration(labelText: "Contact",border: OutlineInputBorder()),),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: () async{

                      final userInfo = new User(username: userNameController.text, password: passwordController.text, email: emailController.text, contact: contactController.text, mode: "farmer",approved: '0', id: '', createdAt: '');
                      var out = await AuthenticationController().createUser(userInfo);
                      if(out){
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Success",
                          desc: "Account Created Successfully",
                          btnOkColor: Colors.green,
                          btnOkOnPress: () => Get.to(Login()),
                        ).show();

                      }
                      else{
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Error",
                          desc: "Something went wrong",
                          btnOkColor: Color.fromARGB(255, 175, 76, 76),
                          btnOkOnPress: () => Get.to(FarmerRegister()),
                        ).show();
                      }


                    },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AgriColors.primaryColor,foregroundColor: AgriColors.whiteColor,fixedSize: Size(AgriColors.screenWidth(context)/2, 50)),
                        child: Text("Create",style: TextStyle(fontSize: 20),)),
              
                    SizedBox(height: 10,),



                  ],),
              
              ),
            )
          ],),
        )
      ),
    );
  }
 void  createFramer(User userInfo) {
    _userController.createUser(userInfo);
  }
  
  
}
