
import 'package:agrihub/Common/CustomerNavBar.dart';
import 'package:agrihub/controller/OrderController.dart';
import 'package:agrihub/model/MyCart.dart';
import 'package:agrihub/pages/customer_ui/AddReview.dart';
import 'package:agrihub/pages/customer_ui/CartPage.dart';
import 'package:agrihub/pages/customer_ui/MyAgriCartPage.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/agri_color.dart';
import '../../controller/ProductController.dart';

class TrackOrder extends StatelessWidget {
  TrackOrder({super.key});
  final ProductController _productController =   Get.put(ProductController());
  final OrderController _orderController =Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
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
        title: Text("Track Orders"),),
      drawer: CustomerNavBar(),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(

                height: AgriColors.screenHeight(context)/1.3,
                width: AgriColors.screenWidth(context),
                child: Obx(
                      () {
                    final farmerProduct = _orderController.trackList;

                    if (farmerProduct.isEmpty) {
                      return Center(
                        child: Text("No Product List"),
                      );
                    }

                    return ListView.builder(
                      itemCount: farmerProduct.length,
                      itemBuilder: (context, index) {
                        final farmerUser = farmerProduct[index];
                        DateTime deliveredAt = DateTime.parse(farmerUser.delivery_at);
                        DateTime currentDate = DateTime.now();
                        Duration difference = deliveredAt.difference(currentDate);
                        var daysPending = difference.inDays;
                       
                        return Card(
                          elevation: 5,
                          child: Expanded(
                            child: Container(
                             
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 5,blurRadius: 7,
                                        offset: Offset(0.3, 0.5)),
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(agriRoute.imageUrl+farmerUser.img,height: 100,width: 100,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(children: [
                                          Text("PID:${farmerUser.purchaseid}",style: TextStyle(fontSize: 16),),
                                          Text(farmerUser.title,style: TextStyle(fontSize: 20),),
                                          Text("OMR. ${farmerUser.subtotal}",style: TextStyle(fontSize: 16),),
                                          Text("Qty: ${farmerUser.quantity}",style: TextStyle(fontSize: 16),),
                                          Text("ordered_At: ${farmerUser.purchased_at}",style: TextStyle(fontSize: 16),),
                                          daysPending<=0?Text("Delivered"): Text("status: ${farmerUser.status}",style: TextStyle(fontSize: 16),),
                                          farmerUser.status=="accepted"?Text("Delivered at: ${farmerUser.delivery_at}"):Text("")
                                        ],),
                                      ),

                                    ],),
                                  daysPending<=0? Padding(
                                    padding: EdgeInsets.only(left: 2),
                                    child: int.parse(farmerUser.quantity)>0?ElevatedButton(

                                      onPressed: () async{
                                        Get.to(AddReview(pid: farmerUser.pid));
                                      }, child: Text("Add Review"),
                                      style: ElevatedButton.styleFrom(

                                        textStyle: TextStyle(fontSize: 16), // Text style
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Button padding
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8), // Button border radius
                                        ),
                                      ),):Text("Out of stock",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                  ):Text("")
                                ],
                              ),


                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ));
  }
}
