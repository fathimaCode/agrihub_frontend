import 'package:agrihub/Common/CustomerNavBar.dart';
import 'package:agrihub/controller/ProductController.dart';
import 'package:agrihub/controller/ReportController.dart';
import 'package:agrihub/model/Report.dart';
import 'package:agrihub/pages/Farmer_ui/ViewIssues.dart';
import 'package:agrihub/pages/customer_ui/CustomerViewIssues.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/FarmerNavBar.dart';
import '../../Constant/agri_color.dart';
import '../../model/MyCart.dart';
import 'MyAgriCartPage.dart';
class CustomerReportIssues extends StatelessWidget {
  CustomerReportIssues({super.key});
  final TextEditingController _commentController = TextEditingController();
  final ProductController _productController = Get.put(ProductController());
  final ReportController _reportGetController = Get.put(ReportController());
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
        title: Text("Report Issues"),
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
              labelText: "Type Issues",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(onPressed: () async{
        var userInfo=await SharedPreferences.getInstance();
        var userid = userInfo.getString("userId")!;
          Report report = new Report(id: '', comments: _commentController.text, userid: userid, response: '', createdAt: '', response_at: '');

          var out =  await _reportGetController.addReport(report);
          if(out){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              showCloseIcon: true,
              title: "Success",
              desc: "Issues send to Admin",
              btnOkOnPress: () => Get.to(CustomerViewIssues()),
              btnOkColor: Colors.green,

            ).show();
            _commentController.text = "";


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

            ).show();
          }

        },
            style: ElevatedButton.styleFrom(
                backgroundColor: AgriColors.primaryColor,foregroundColor: AgriColors.whiteColor,fixedSize: Size(AgriColors.screenWidth(context)/2, 50)),
            child: Text("Create",style: TextStyle(fontSize: 20),)),
      ],
    ));
  }
}
