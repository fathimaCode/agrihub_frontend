
import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/controller/ReportController.dart';
import 'package:agrihub/pages/admin_ui/AddAgriInfo.dart';
import 'package:agrihub/pages/admin_ui/AdminViewIssues.dart';
import 'package:agrihub/pages/admin_ui/ViewFarmer.dart';
import 'package:agrihub/pages/admin_ui/ViewOrders.dart';
import 'package:agrihub/pages/admin_ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/OrderController.dart';
import '../controller/ProductController.dart';
import '../pages/Login.dart';
class AdminNavBar extends StatelessWidget {
  AdminNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
     child:ListView(children: [
          UserAccountsDrawerHeader(
            accountName: Text("Admin"),
            accountEmail: Text("admin@agrihub.com"),
            currentAccountPicture: CircleAvatar(child: Image.asset('assets/images/profile.jpg')
              ,),decoration: BoxDecoration(color: AgriColors.primaryColor),),
       ListTile(leading: Icon(Icons.home),title: Text("Dashboard"),onTap: ()=>{
         Get.to(Admindashboard())
       },),
           ListTile(leading: Icon(Icons.agriculture),title: Text("Add Agri Info"),onTap: ()=>{Get.to(AddAgriInfo())},),
           ListTile(leading: Icon(Icons.people),title: Text("View Farmer"),onTap: ()=>{Get.to(ViewFarmer())},),
           ListTile(leading: Icon(Icons.other_houses_rounded),title: Text("View Orders"),onTap: ()=>{

             Get.to(ViewOrders())
           },),
           ListTile(leading: Icon(Icons.feed),title: Text("View Issues"),onTap: ()=>{Get.to(AdminViewIssues())},),
              ListTile(leading: Icon(Icons.logout),title: Text("Logout"),onTap: ()=>{

                Get.to(Login())},)


     ],)
    );
  }
}
