import 'dart:convert';

import 'package:agrihub/model/Report.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:http/http.dart' as http;
class ReportService{
  Future<String> add(Report report) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.reportUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({

          'userId': report.userid,
          'comments': report.comments,
          'createIssues':1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> getReportById(String userId) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.reportUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({

          'userid': userId,

          'issueById':1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> getReport() async {
    try {
      final response = await http.post(Uri.parse(agriRoute.reportUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'issuesList':1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }  Future<String> solutions(String comment, String issueid) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.reportUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'createsolutions':1,
          'comment':comment,
          'issueid':issueid
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }

}