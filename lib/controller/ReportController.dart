
import 'dart:convert';

import 'package:agrihub/model/Agriculture.dart';
import 'package:agrihub/model/ReportAdmin.dart';
import 'package:agrihub/services/ReportService.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Report.dart';
import '../model/User.dart';
import '../services/AgricultureService.dart';

class ReportController extends GetxController{
  var issues = [].obs;
  var adminReport = [].obs;
  @override
  void onInit() {
    super.onInit();
    initalRefreshFunctions();

  }
  void initalRefreshFunctions() {
    fetchIssuedetails();
    adminIssues();
  }
  Future<bool> addReport(Report report) async{
    try{
      var resp=  await ReportService().add(report);
      initalRefreshFunctions();
      print(resp);
      return true;

    }catch(e){
      print("Error creating user: $e"); // Log the error
      return false;
    }
    finally{


    }
  }
  Future<bool> addSolutions(String comments, String issueid) async{
    try{
      var resp=  await ReportService().solutions(comments, issueid);
      initalRefreshFunctions();
      print(resp);
      return true;

    }catch(e){
      print("Error creating user: $e"); // Log the error
      return false;
    }
    finally{


    }
  }
  void fetchIssuedetails() async{
    var userInfo=await SharedPreferences.getInstance();
    var userid = userInfo.getString("userId")!;
    var resp = await ReportService().getReportById(userid);
    var productList = jsonDecode(resp);
   issues.assignAll(productList.map((e)=>Report.fromJson(e)).toList());
    print("line 71 : get issue list: ${resp}");
  }
  void adminIssues() async{
    var resp = await ReportService().getReport();
    var productList = jsonDecode(resp);
    adminReport.assignAll(productList.map((e)=>ReportAdmin.fromJson(e)).toList());
    print("line 71 : get issue list: ${productList}");
  }
}