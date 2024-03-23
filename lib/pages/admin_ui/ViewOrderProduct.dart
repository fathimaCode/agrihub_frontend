import 'package:agrihub/routes/agriRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/NavBar.dart';
import '../../controller/OrderController.dart';

class ViewOrderProduct extends StatelessWidget {
  ViewOrderProduct({super.key});
  final OrderController _orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Product Details"),),
      drawer: AdminNavBar(),
      body: Obx(
            () {
          final orderList = _orderController.orderProductList;

          if (orderList.isEmpty) {
            return Center(
              child: Text("No Orders List"),
            );
          }

          return ListView.builder(
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              final orders = orderList[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      child: Row(
                        children: [
                          Image.network(agriRoute.imageUrl+orders.image,height: 100,width: 100,),
                          Container(
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(orders.title),
                              )
                              ,   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Qt: ${orders.quantity}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("OMR: ${orders.subbtotal}"),
                              )

                            ],),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
