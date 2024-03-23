import 'package:agrihub/Common/CustomerNavBar.dart';
import 'package:agrihub/controller/ProductController.dart';
import 'package:agrihub/controller/ReportController.dart';
import 'package:agrihub/controller/ReviewController.dart';
import 'package:agrihub/model/Report.dart';
import 'package:agrihub/model/ReviewView.dart';
import 'package:agrihub/pages/Farmer_ui/ViewIssues.dart';
import 'package:agrihub/pages/Farmer_ui/dashboard.dart';
import 'package:agrihub/pages/customer_ui/CustomerViewIssues.dart';
import 'package:agrihub/pages/customer_ui/dashboard.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/FarmerNavBar.dart';
import '../../Constant/agri_color.dart';
import '../../model/MyCart.dart';
import 'MyAgriCartPage.dart';
class AddReview extends StatelessWidget {
  var pid;
  AddReview({super.key, required this.pid});
  final TextEditingController _commentController = TextEditingController();
  final ReviewController _reviewController = Get.put(ReviewController());

  final ProductController _productController = Get.put(ProductController());
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

            }, icon: Icon(Icons.add_shopping_cart,color: AgriColors.primaryColor,)),
          ],
        title: Text("Add Reviews"),
    ),
    drawer: CustomerNavBar(),
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _commentController,
            decoration: InputDecoration(
              labelText: "Type Reviews",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(onPressed: () async{
        var userInfo=await SharedPreferences.getInstance();
        var userid = userInfo.getString("userId")!;
          ReviewView review = new ReviewView(pid: pid, userId: userid, comments: _commentController.text);

          var out =  await _reviewController.addReview(review);
        if(out){
          Get.snackbar("Success", "Review Added Successfully",snackPosition: SnackPosition.TOP,backgroundColor: AgriColors.primaryColor,colorText: AgriColors.whiteColor);
          Future.delayed(Duration(seconds: 2), () {
            Get.off(Customerdashboard());
          });
        }
        else{
          Get.snackbar("Error", "Something Went Wrong",snackPosition: SnackPosition.TOP);
        }

        },
            style: ElevatedButton.styleFrom(
                backgroundColor: AgriColors.primaryColor,foregroundColor: AgriColors.whiteColor,fixedSize: Size(AgriColors.screenWidth(context)/2, 50)),
            child: Text("Add",style: TextStyle(fontSize: 20),)),
      ],
    ));
  }
}
