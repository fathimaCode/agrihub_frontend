import 'dart:convert';

import 'package:agrihub/routes/agriRoute.dart';
import 'package:http/http.dart' as http;

import '../model/ReviewView.dart';
class ReviewService{
  Future<String> add(ReviewView review) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.reviewUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({

          'pid': review.pid,
          'userId': review.userId,
          'comments': review.comments,
          'createReview':1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
  Future<String> getAllReviews(String pid) async {
    try {
      final response = await http.post(Uri.parse(agriRoute.reviewUrl),
        headers: {
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode({

          'pid': pid,

          'reviewByProductId':1
        }),
      );

      return response.body;


    } catch (e) {

      print('Error creating user: $e');
      rethrow; // Re-throwing the error for the caller to handle
    }

  }
}