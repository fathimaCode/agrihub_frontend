
import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/pages/Farmer_ui/AddProduct.dart';
import 'package:agrihub/pages/Farmer_ui/ViewIssues.dart';
import 'package:agrihub/pages/Farmer_ui/ViewProduct.dart';
import 'package:agrihub/pages/Farmer_ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/ProductController.dart';
import '../controller/ReportController.dart';

import '../pages/Login.dart';
class FarmerNavBar extends StatelessWidget {
  FarmerNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(future: SharedPreferences.getInstance(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){

            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final SharedPreferences prefs = snapshot.data!;
          String? approved = prefs.getString("approved");
          String? username = prefs.getString("username");
          String? email = prefs.getString("email");
          return Drawer(
              child:ListView(children: [
                UserAccountsDrawerHeader(
                  accountName: Text(username!),
                  accountEmail: Text(email!),
                  currentAccountPicture: CircleAvatar(child: Image.asset('assets/images/profile.jpg')
                    ,),decoration: BoxDecoration(color: AgriColors.primaryColor),),
                ListTile(leading: Icon(Icons.home),title: Text("Dashboard"),onTap: ()=>{
                  Get.to(dashboard())
                },),
                approved=="1"? ListTile(leading: Icon(Icons.add_box),title: Text("product"),onTap: ()=>{

                  Get.to(ViewProduct())
                },):ListTile(leading: Icon(Icons.add_box),title: Text("Add product"),onTap: ()=>{

                },),
                ListTile(leading: Icon(Icons.feed),title: Text("Report Issues"),onTap: ()=>{

                  Get.to(ViewIssues())
                },),
                ListTile(leading: Icon(Icons.logout),title: Text("Logout"),onTap: ()=>{

                  Get.to(Login()) ,},)


              ],)
          );
    });
  }
}
