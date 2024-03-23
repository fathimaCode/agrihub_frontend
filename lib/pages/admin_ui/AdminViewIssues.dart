import 'package:agrihub/Common/NavBar.dart';
import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/controller/ReportController.dart';
import 'package:agrihub/pages/Farmer_ui/AddProduct.dart';
import 'package:agrihub/pages/Farmer_ui/FarmerReportIssues.dart';
import 'package:agrihub/pages/admin_ui/AdminSolution.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/FarmerNavBar.dart';
import '../../controller/ProductController.dart';

class AdminViewIssues extends StatelessWidget {
  AdminViewIssues({super.key});
  final ReportController _reportController =   Get.put(ReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Issues"),
        ),
        drawer: AdminNavBar(),
        body: ListView(
          children: [


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(

                  height: AgriColors.screenHeight(context)/1.3,
                  width: AgriColors.screenWidth(context),
                  child: Obx(
                        () {
                      final issueDetails = _reportController.adminReport;

                      if (issueDetails.isEmpty) {
                        return Center(
                          child: Text("No Issues Reported"),
                        );
                      }

                      return ListView.builder(
                        itemCount: issueDetails.length,
                        itemBuilder: (context, index) {
                          final issues = issueDetails[index];
                          return Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 5,blurRadius: 7,
                                        offset: Offset(0.3, 0.5)),
                                  ]
                              ),
                              child: Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(

                                            alignment:Alignment.topRight,
                                            margin: EdgeInsets.only(left: 0),
                                            child: Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Report By ${issues.username}"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Report At: ${issues.createdAt}",style: TextStyle(fontSize: 12,color: AgriColors.blackColor),),
                                              )],)
                                        ),
                                        Text(issues.comments,style: TextStyle(fontSize: 16,color: AgriColors.blackColor),),
                                        issues.response==""?ElevatedButton(
                                            onPressed: (){
                                              print(issues.id);
                                              Get.to(AdminSolution(issueId: issues.id,));
                                            }, child: Text("Answer")):
                                        Container(
                                          margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: Colors.green),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(issues.response),
                                                ),
                                            Text("Replied At: ${issues.response_at}")
                                                                                    ],),
                                          ),)
                                      ],),
                                  )

                                ],),),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
