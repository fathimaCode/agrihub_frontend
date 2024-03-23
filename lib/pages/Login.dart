import 'dart:convert';

import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/pages/Farmer_ui/dashboard.dart';
import 'package:agrihub/pages/admin_ui/AddAgriInfo.dart';
import 'package:agrihub/pages/admin_ui/dashboard.dart';
import 'package:agrihub/pages/customer_register.dart';
import 'package:agrihub/pages/customer_ui/dashboard.dart';
import 'package:agrihub/pages/farmer_register.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/AuthenticationController.dart';

class Login extends StatelessWidget {
   Login({Key? key});
   final AuthenticationController _userController =
   Get.put(AuthenticationController());
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AgriColors.screenHeight(context),
          width: AgriColors.screenWidth(context),
          decoration: BoxDecoration(color: AgriColors.primaryColor),
          child: Column(
            children: [
              SizedBox(height: 65), // Added SizedBox for spacing
              Text(
                "Welcome",
                style: TextStyle(fontSize: 25, color: AgriColors.whiteColor),
              ),
              Text(
                "Sign in to continue !",
                style: TextStyle(fontSize: 16, color: AgriColors.whiteColor),
              ),
              SizedBox(height: 50),
              Container(
        
                height: AgriColors.screenHeight(context)/1.7,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AgriColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AgriColors.whiteColor, style: BorderStyle.solid, width: 1)),
                child: Column(
        
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(  controller: emailController, decoration: InputDecoration(labelText: "Email Address",border: OutlineInputBorder()),),
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
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: () async{
                      if(emailController.text=="admin@agrihub.com" && passwordController.text=="admin"){
                        Get.to(Admindashboard());
                      }
                      else{
                        var result=   await AuthenticationController().AuthorisedUser(emailController.text,passwordController.text);
                        print("line 71 ${result}");
                        var res = json.decode(result);
                        //print(res.isEmpty?"this is empty":"not an empty");
                        if(res.isEmpty){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "Error",
                            desc: "Invalid useremail or password",
                            btnOkColor: Color.fromARGB(255, 175, 76, 76),
                            btnOkOnPress: () => Get.to(Login()),
                          ).show();
                        }
                        else{
                          var userid = res[0]["id"].toString();
                          var mode=res[0]["mode"].toString();
                          var name=res[0]["name"].toString();
                          var email=res[0]["email"].toString();
                          var approved=res[0]["approved"].toString();
                          print("line 92:${mode}, ${userid}");
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.setString("userId", userid);
                          pref.setString("userMode", mode);
                          pref.setString("username", name);
                          pref.setString("email", email);
                          if(mode=="farmer"){
                            pref.setString("approved", approved);
                            Get.to(dashboard());
                          }
                          else if(mode=="customer"){

                            Get.to(Customerdashboard());
                          }
                        }

                      }


                    },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AgriColors.primaryColor,foregroundColor: AgriColors.whiteColor,fixedSize: Size(AgriColors.screenWidth(context)/2, 50)),
                        child: Text("Login",style: TextStyle(fontSize: 20),)),

                    SizedBox(height: 10,),

                    Text("Or" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,), Text("Create a new account"),
                    SizedBox(height: 5,),

                    Row(
              mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(FarmerRegister());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/images/1.jpg'
                            ,width: 80,height: 60,),
                        ),
                      ),
                        SizedBox(width: 15,),
                        GestureDetector(
                          onTap: (){
                            Get.to(CustomerRegister());
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/images/3.jpg'
                              ,width: 80,height: 60,),
                          ),
                        ),

                    ],)
                  ],),
        
              )
            ],
        
          ),
        ),
      ),
    );
  }
}
