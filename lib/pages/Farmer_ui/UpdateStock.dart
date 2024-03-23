import 'package:agrihub/controller/ProductController.dart';
import 'package:agrihub/controller/ReportController.dart';
import 'package:agrihub/model/Report.dart';
import 'package:agrihub/pages/Farmer_ui/ViewIssues.dart';
import 'package:agrihub/pages/Farmer_ui/ViewProduct.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/FarmerNavBar.dart';
import '../../Constant/agri_color.dart';
class UpdateStock extends StatelessWidget {
  var pid;
  UpdateStock({super.key,required this.pid});
  final TextEditingController _commentController = TextEditingController();
  final ProductController _productController = Get.put(ProductController());
  final ReportController _reportGetController = Get.put(ReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Update Stock"),
    ),
    drawer: FarmerNavBar(),
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _commentController,
            decoration: InputDecoration(
              labelText: "Type Stock",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(onPressed: () async{




          var out =  await _productController.updateStock(pid,_commentController.text);
          if(out){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              showCloseIcon: true,
              title: "Success",
              desc: "Stock Updated",
              btnOkOnPress: () => Get.to(ViewProduct()),
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
            child: Text("update",style: TextStyle(fontSize: 20),)),
      ],
    ));
  }
}
