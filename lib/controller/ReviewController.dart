import 'dart:convert';

import 'package:agrihub/model/CustomerReview.dart';
import 'package:agrihub/services/ReviewService.dart';
import 'package:get/get.dart';

import '../model/ReviewView.dart';

class ReviewController extends GetxController{
  var productId ="".obs;
  var customerReviewList = [].obs;
  Future<bool> addReview(ReviewView review) async{
    try{
      var resp=  await ReviewService().add(review);

      print(resp);
      return true;

    }catch(e){
      print("Error creating user: $e"); // Log the error
      return false;
    }
    finally{


    }
  }
  void getReviews() async{

    var resp = await ReviewService().getAllReviews(productId.value);
    var reviewList = jsonDecode(resp);
    customerReviewList.assignAll(reviewList.map((e)=>CustomerReview.fromJson(e)).toList());
    print("line 31 : get product list: ${reviewList}");
  }
}