import 'dart:math';

import 'package:agrihub/model/CartItem.dart';
import 'package:agrihub/pages/customer_ui/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/CustomerNavBar.dart';
import '../../Constant/agri_color.dart';
import '../../controller/ProductController.dart';

import '../../model/MyCart.dart';

class MyAgriCartPage extends StatelessWidget {
  final List<MyCart> cartItems;

  MyAgriCartPage({Key? key, required this.cartItems}) : super(key: key);
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    double totalAmount =0;
    cartItems.forEach((element) {
      var amount = int.parse(element.subbtotal);
      totalAmount +=amount;
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {

            _productController.initalRefreshFunctions();
            _productController.fetchCartItem();
            var carts = _productController.myCart;
            List<MyCart> items = new List<MyCart>.from(carts);
            Get.to(MyAgriCartPage(cartItems: items));

          }, icon: Icon(Icons.add_shopping_cart,color: AgriColors.primaryColor,))],
        title: Text("Cart Items"),
      ),
      drawer: CustomerNavBar(),
      body:ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(

                height: AgriColors.screenHeight(context)/1.3,
                width: AgriColors.screenWidth(context),
                child:cartItems.isEmpty?Text("No cart Items"): ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cart = cartItems[index];
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
                            Image.network(agriRoute.imageUrl+cart.image,height: 100,width: 100,),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(children: [
                                Text(cart.title,style: TextStyle(fontSize: 20),),
                                Text("OMR. ${cart.subbtotal}",style: TextStyle(fontSize: 16),),
                                Text("Qty: ${cart.quantity}",style: TextStyle(fontSize: 16),)
                              ],),
                            ),

                          ],),),
                    );
                  },
                )
            ),
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Total Amount- OMR: ${totalAmount}"),
                    ),
                    ElevatedButton(onPressed: () async{
                      Random random = Random();
                      int randomNumber = random.nextInt(100001);
                      var purchaseId = "PURC${randomNumber}";


                      var userInfo=await SharedPreferences.getInstance();
                      var userid = userInfo.getString("userId")!;
                      var out = await _productController.productPurchase(userid, purchaseId);
                      if(out){
                        _productController.initalRefreshFunctions();
                        Get.snackbar("Success", "Item Purchased",snackPosition: SnackPosition.TOP,backgroundColor: AgriColors.primaryColor,colorText: AgriColors.whiteColor);
                        Future.delayed(Duration(seconds: 2), () {
                          Get.off(Customerdashboard());
                        });
                      }
                      else{
                        Get.snackbar("Error", "Something Went Wrong",snackPosition: SnackPosition.TOP);
                      }
                    }, child: Text("Purchase"))
                  ],),),),
            )
          ],
        )
      ],)
    );
  }
}
