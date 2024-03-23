
import 'package:agrihub/Common/CustomerNavBar.dart';
import 'package:agrihub/controller/ReviewController.dart';
import 'package:agrihub/model/MyCart.dart';
import 'package:agrihub/pages/customer_ui/CartPage.dart';
import 'package:agrihub/pages/customer_ui/MyAgriCartPage.dart';
import 'package:agrihub/pages/customer_ui/ProductCustomerReview.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/agri_color.dart';
import '../../controller/ProductController.dart';

class Customerdashboard extends StatelessWidget {
  Customerdashboard({super.key});
  final ProductController _productController =   Get.put(ProductController());
  final ReviewController _reviewController =   Get.put(ReviewController());
  final TextEditingController _searchController = TextEditingController();
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
        title: Text("Dashboard"),),
      drawer: CustomerNavBar(),
      body: ListView(
        children: [
          Container(


            padding: EdgeInsets.only(right: 15,bottom: 10),
            alignment: Alignment.topRight,
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: "Search Product",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  var searchInput = _searchController.text;
                  _productController.filterProducts.value = _productController.products
                      .where((agriItem) =>
                  agriItem.title.toLowerCase().contains(searchInput.toLowerCase()) ||
                      agriItem.description.toLowerCase().contains(searchInput.toLowerCase()))
                      .toList();
                  print("line 50");

                },child: Text("Search",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),)],),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(

                height: AgriColors.screenHeight(context)/1.3,
                width: AgriColors.screenWidth(context),
                child: Obx(
                      () {
                    final farmerProduct = _productController.filterProducts.isEmpty? _productController.products:_productController.filterProducts;

                    if (farmerProduct.isEmpty) {
                      return Center(
                        child: Text("No Product List"),
                      );
                    }

                    return ListView.builder(
                      itemCount: farmerProduct.length,
                      itemBuilder: (context, index) {
                        final farmerUser = farmerProduct[index];
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
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(agriRoute.imageUrl+farmerUser.img,height: 100,width: 100,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(children: [
                                        Text(farmerUser.title,style: TextStyle(fontSize: 20),),
                                        Text("OMR. ${farmerUser.price}",style: TextStyle(fontSize: 16),),
                                        Text("Qty: ${farmerUser.quantity}",style: TextStyle(fontSize: 16),)
                                      ],),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: int.parse(farmerUser.quantity)>0?ElevatedButton(
                                
                                        onPressed: () async{
                                          print(farmerUser.id);
                                          var productItem= await  _productController.fetchProductDetails(farmerUser.id);
                                          Get.to(CartPage(productItem: productItem));
                                
                                        }, child: Text("Buy"),
                                        style: ElevatedButton.styleFrom(
                                
                                          textStyle: TextStyle(fontSize: 16), // Text style
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Button padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8), // Button border radius
                                          ),
                                        ),):Text("Out of stock",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                    )
                                  ],),
                               GestureDetector(
                                 onTap: (){
                                   _reviewController.productId.value = farmerUser.id;
                                   _reviewController.getReviews();
                                   Get.to(ProductCustomerReview());
                                 },
                                 child: Padding(padding: EdgeInsets.all(8),
                                   child:  Text("View Review",style: TextStyle(color: Colors.green),),),
                               )
                              ],
                            ),),
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
