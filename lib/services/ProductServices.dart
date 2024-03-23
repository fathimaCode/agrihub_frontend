import 'dart:convert';


import 'package:agrihub/model/Product.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../model/CartItem.dart';
class ProductServices{
  Future<String> add(Product product) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(agriRoute.productUrl));
     return "";

    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> stockUpdate(String pid,String stockCount) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.productUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'updateStock': '1',
          'pid':pid,
          'stockCount':stockCount,
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> productListByFarmerId(String userid) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.productUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'getProductByFarmer': '1',
          'userid':userid
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> getPurchaseList(String purchaseId) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.purchaseUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'getPurchaseList': '1',
          'purchaseId': purchaseId,

        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> closeOrder(String purchaseId) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.purchaseUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'acceptOrder': '1',
          'purchaseId': purchaseId,

        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> trackMyOrders(String userid) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.purchaseUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'trackMyOrder': '1',
          'userid': userid,

        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> productList() async {
    try {
      final response = await http.post(Uri.parse(agriRoute.productUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'getProduct': '1',

        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> viewProduct(String pid) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.productUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'getProductById': '1',
          'pid': pid

        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> viewCartItems(String userid) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.cartUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'cartDetails': '1',
          'userid': userid

        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> purchaseItem(String userid,String purchaseId) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.cartUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'purchaseItem': '1',
          'userid': userid,
          'purchaseId': purchaseId

        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  // Here order list has to show in the admin panel
  Future<String> OrderList() async {
    try {
      final response = await http.post(Uri.parse(agriRoute.purchaseUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({
          'orderList': '1',


        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> addToCart(CartItem cart) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.cartUrl),
        headers: {
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          'userid': cart.userid,
          'quantity': cart.quantity,
          'pid': cart.pid,
          'subtotal': cart.subbtotal,
          'addToCart':1
        }),
      );

      return response.body;

    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }

}

