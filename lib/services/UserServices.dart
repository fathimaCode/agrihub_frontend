import 'dart:convert';

import 'package:agrihub/model/User.dart';
import 'package:agrihub/routes/agriRoute.dart';

import 'package:http/http.dart' as http;

import '../pages/Login.dart';

class UserServices {
  Future<String> createUser(User user) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.createUserUrl),
        headers: {
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          'username': user.username,
          'email': user.email,
          'contact': user.contact,
          'password': user.password,
          'mode': user.mode,
          'create_user':1
        }),
      );

      return response.body;

    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> isUserExist(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.createUserUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({

          'password': password,
          'email': email,
          'authorised':1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> isFarmer() async {
    try {
      final response = await http.post(Uri.parse(agriRoute.createUserUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({

         "isFarmer":1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> updateFarmerStatus(String userid) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.createUserUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          "userid":userid,
          "activate":1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
}
