import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/MyProducts.dart';
import '../model/TrackOrders.dart';
import '../services/ProductServices.dart';

class OrderController extends GetxController{
  var orderProductList = [].obs;
  var trackList = [].obs;
  var purchaseId = "".obs;
  var remainingQuantity = "".obs;
  @override
  void onInit() {
    super.onInit();
    initalRefreshFunctions();
  }
  void initalRefreshFunctions() async{
    fetchProductListToAdmin();
    fetchTrackList();

  }
  Future<bool> acceptOrderByAdmin(String purchaseId) async{


    try{
      var resp=  await ProductServices().closeOrder(purchaseId);


      print(resp);
      return true;

    }catch(e){
      print("Error creating user: $e"); // Log the error
      return false;
    }

  }

  void fetchProductListToAdmin() async{
    var resp = await ProductServices().getPurchaseList(purchaseId.value);
    var orders = jsonDecode(resp);
    print(orders);
    orderProductList.assignAll(orders.map((e)=>MyProducts.fromJson(e)).toList());
    print("line 145 : purchaseList : ${orders}");
  }
  void fetchTrackList() async{

    var userInfo=await SharedPreferences.getInstance();
    var userid = userInfo.getString("userId")!;
    var resp = await ProductServices().trackMyOrders(userid);
    var orders = jsonDecode(resp);
    print(orders);
    trackList.assignAll(orders.map((e)=>TrackOrders.fromJson(e)).toList());
    print("line 145 : purchaseList : ${orders}");
  }
}