
import 'dart:convert';
import 'dart:io';

import 'package:agrihub/model/CartItem.dart';
import 'package:agrihub/model/FarmerProduct.dart';
import 'package:agrihub/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/MyCart.dart';
import '../model/OrderAdminView.dart';
import '../services/ProductServices.dart';
class ProductController extends GetxController{

var isLoading = false.obs;
var userId ="".obs;
var quantity=0.obs;
var subtotal=0.obs;
var farmerUsers = [].obs;
var orderList = [].obs;
var farmerProduct = [].obs;
var products = [].obs;
var myCart = [].obs;
var filterProducts = [].obs;
RxBool imageSelected = false.obs;
Rx<File?> filePath = Rx<File?>(null);
XFile? _image;
final ImagePicker _picker = ImagePicker();

@override
void onInit() {
  super.onInit();

  initalRefreshFunctions();
}
void initalRefreshFunctions() async{
  fetchProduct();
  await getUserId();
  fetchFarmerProduct();
  quantity.value=1;
  fetchCartItem();
  fetchOrderListToAdmin();

}
Future<void> chooseImage() async{
  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if(pickedFile != null){
    imageSelected.value = true;
    _image = pickedFile;
    filePath.value = File(_image!.path);


  }
  else{
    print("No image selected");
    return null;
  }
}
Future<void> getUserId() async{

  var userInfo=await SharedPreferences.getInstance();
  userId.value = userInfo.getString("userId")!;
  print("line 48: ${userId.value}");
}
Future<bool> addProduct(Product product) async{

  isLoading.value = true;
  try{
  var resp=  await ProductServices().add(product);
  await getUserId();

  print(resp);
  return true;

  }catch(e){
    print("Error creating user: $e"); // Log the error
    return false;
  }
  finally{
    isLoading.value=false;

  }
}
Future<bool> addCart(CartItem product) async{

  isLoading.value = true;
  try{
    var resp=  await ProductServices().addToCart(product);


    print(resp);
    return true;

  }catch(e){
    print("Error creating user: $e"); // Log the error
    return false;
  }
  finally{
    isLoading.value=false;

  }
}
Future<bool> productPurchase(String userid,String purchaseId) async{

  isLoading.value = true;
  try{
    var resp=  await ProductServices().purchaseItem(userid,purchaseId);


    print(resp);
    return true;

  }catch(e){
    print("Error creating user: $e"); // Log the error
    return false;
  }
  finally{
    isLoading.value=false;

  }
}
Future<bool> updateStock(String pid,String stockCount) async{

  isLoading.value = true;
  try{
    var resp=  await ProductServices().stockUpdate(pid,stockCount);


    print(resp);
    return true;

  }catch(e){
    print("Error creating user: $e"); // Log the error
    return false;
  }
  finally{
    isLoading.value=false;

  }
}
Future<FarmerProduct> fetchProductDetails(String productId) async{
  var resp = await ProductServices().viewProduct(productId);
  var product = jsonDecode(resp);
  print(product[0]["description"]);
  var agriProduct = new FarmerProduct(id: product[0]["id"], title: product[0]["title"], quantity: product[0]["quantity"],
      description: product[0]["description"], price: product[0]["price"], img: product[0]["img"], created_at: product[0]["created_at"]);
return agriProduct;
}
void fetchFarmerProduct() async{
  var userInfo=await SharedPreferences.getInstance();
  userId.value = userInfo.getString("userId")!;
  print("product controller${userId.value}");
  var resp = await ProductServices().productListByFarmerId(userId.value);
  var productList = jsonDecode(resp);
  farmerProduct.assignAll(productList.map((e)=>FarmerProduct.fromJson(e)).toList());
  print("line 71 : get product list: ${resp}");
}
void fetchOrderListToAdmin() async{
  var resp = await ProductServices().OrderList();
  var orders = jsonDecode(resp);
  orderList.assignAll(orders.map((e)=>OrderAdminView.fromJson(e)).toList());
  print("line 145 : orderlist : ${resp}");
}
void fetchCartItem() async{
  var userInfo=await SharedPreferences.getInstance();
  userId.value = userInfo.getString("userId")!;
  print("product controller${userId.value}");
  var resp = await ProductServices().viewCartItems(userId.value);
  var productList = jsonDecode(resp);
  print(productList);
  myCart.assignAll(productList.map((e)=>MyCart.fromJson(e)).toList());
  print("line 156 : get cartitems: ${resp}");
}
void fetchProduct() async{

  var resp = await ProductServices().productList();
  var productList = jsonDecode(resp);
  products.assignAll(productList.map((e)=>FarmerProduct.fromJson(e)).toList());
  print("line 71 : get product list: ${resp}");
}

}