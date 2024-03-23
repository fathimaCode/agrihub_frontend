
import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/ProductController.dart';
import '../controller/ReportController.dart';
import '../pages/customer_ui/CustomerViewIssues.dart';
import '../pages/customer_ui/TrackOrders.dart';
import '../pages/customer_ui/dashboard.dart';
class CustomerNavBar extends StatelessWidget {
  CustomerNavBar({super.key});

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
                ListTile(leading: Icon(Icons.home),title: Text("Dashboard"),
                  onTap: ()=>{

                  Get.to(Customerdashboard())
                },),
                ListTile(leading: Icon(Icons.directions_boat),title: Text("Track Orders"),
                  onTap: ()=>{
                    Get.to(TrackOrder())
                },),
                ListTile(leading: Icon(Icons.feed),
                  title: Text("Report Issues"),onTap: ()=>{

                  Get.to(CustomerViewIssues())
                },),
                ListTile(leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: ()=>{

                  Get.to(Login())
                  },)


              ],)
          );
        });
  }
}
