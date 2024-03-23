import 'dart:convert';

import 'package:agrihub/model/Agriculture.dart';
import 'package:agrihub/model/User.dart';
import 'package:agrihub/routes/agriRoute.dart';

import 'package:http/http.dart' as http;

import '../pages/Login.dart';

class AgricultureService {
  Future<String> createAgriculture(Agriculture agriculture) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.agriInfoUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },

        body: jsonEncode({
          'title': agriculture.title,
          'description': agriculture.description,
          'content': agriculture.content,
          'createAgriInfo':1
        }),
      );

      return response.body;

    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }

  Future<String> getAllAgriInfo() async {
    try {
      final response = await http.post(Uri.parse(agriRoute.agriInfoUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({


          'getAgri':1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
}
