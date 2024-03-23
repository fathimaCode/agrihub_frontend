import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/pages/Farmer_ui/AddProduct.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/FarmerNavBar.dart';
import '../../controller/ProductController.dart';

class ViewProduct extends StatelessWidget {
  ViewProduct({super.key});
  final ProductController _productController =   Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        actions: [IconButton(onPressed: (){
          print(_productController.userId.value);
          _productController.initalRefreshFunctions();
          _productController.fetchFarmerProduct();
        }, icon: Icon(Icons.refresh))],
        title: Text("View Product"),
    ),
    drawer: FarmerNavBar(),
    body: ListView(
      children: [
        Container(


          padding: EdgeInsets.only(right: 15,bottom: 10),
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: (){
            Get.to(AddProduct());
          },child: Text("Add Product",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
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
                  final farmerProduct = _productController.farmerProduct;

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
                          child: Row(
                            children: [
                          Image.network(agriRoute.imageUrl+farmerUser.img,height: 100,width: 100,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(children: [
                                  Text(farmerUser.title,style: TextStyle(fontSize: 20),),
                                  Text("OMR. ${farmerUser.price}",style: TextStyle(fontSize: 16),),
                                  Text("Qty: ${farmerUser.quantity}",style: TextStyle(fontSize: 16),)
                                ],),
                              )
                              
                        ],),),
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
