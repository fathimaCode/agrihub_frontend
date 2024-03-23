
import 'package:agrihub/Common/CustomerNavBar.dart';
import 'package:agrihub/controller/ReviewController.dart';
import 'package:agrihub/model/MyCart.dart';
import 'package:agrihub/pages/customer_ui/CartPage.dart';
import 'package:agrihub/pages/customer_ui/MyAgriCartPage.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/agri_color.dart';
import '../../controller/ProductController.dart';

class ProductCustomerReview extends StatelessWidget {
  ProductCustomerReview({super.key});
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
        title: Text("Reviews"),),
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
                    final farmerProduct = _reviewController.customerReviewList;

                    if (farmerProduct.isEmpty) {
                      return Center(
                        child: Text("No Comments"),
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

                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(children: [
                                        Text(farmerUser.comments,style: TextStyle(fontSize: 20),),
                                        Text("Comment by: ${farmerUser.name} on ${farmerUser.created_at}",style: TextStyle(fontSize: 16),),

                                      ],),
                                    ),

                                  ],),

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
