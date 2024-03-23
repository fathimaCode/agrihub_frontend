import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/controller/AuthenticationController.dart';
import 'package:agrihub/controller/ProductController.dart';
import 'package:agrihub/pages/admin_ui/ViewOrderProduct.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/NavBar.dart';
import '../../controller/OrderController.dart';

class ViewOrders extends StatelessWidget {
  ViewOrders({super.key});
  final ProductController _productController = Get.put(ProductController());
  final OrderController _orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Orders"),

      ),
      drawer: AdminNavBar(),
      body: Obx(
            () {
          final orderList = _productController.orderList;

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
                  child: GestureDetector(
                    onTap: (){
                      print(orders.purchaseid);
                      _orderController.purchaseId.value = orders.purchaseid;
                      _orderController.initalRefreshFunctions();

                      Get.to(ViewOrderProduct());
                    },
                    child: ListTile(
                      title: Text(orders.purchaseid),
                      subtitle: Text("purchased at ${orders.purchased_at}"),
                      trailing:orders.status=="request"?ElevatedButton(onPressed:() async{
                       var out = await _orderController.acceptOrderByAdmin(orders.purchaseid);
                        _productController.fetchOrderListToAdmin();
                        if(out){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "Success",
                            desc: "Order is Confirmed",
                            btnOkColor: Colors.green,
                            btnOkOnPress: () => Get.to(ViewOrders()),
                          ).show();

                        }
                        else{
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "Error",
                            desc: "Something went wrong",
                            btnOkColor: Color.fromARGB(255, 175, 76, 76),
                            btnOkOnPress: () => Get.to(ViewOrders()),
                          ).show();
                        }
                      } ,child: Text("Accept"),):Text(orders.status),
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
