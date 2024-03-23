import 'package:agrihub/Common/NavBar.dart';
import 'package:agrihub/controller/ProductController.dart';
import 'package:agrihub/controller/ReportController.dart';
import 'package:agrihub/model/Report.dart';
import 'package:agrihub/pages/admin_ui/AdminViewIssues.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/FarmerNavBar.dart';
import '../../Constant/agri_color.dart';
class AdminSolution extends StatelessWidget {
  var issueId;
  AdminSolution({super.key, required this.issueId});
  final TextEditingController _commentController = TextEditingController();

  final ReportController _reportGetController = Get.put(ReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Solution for Issues"),
    ),
    drawer: AdminNavBar(),
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _commentController,
            decoration: InputDecoration(
              labelText: "Type Solutions",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(onPressed: () async{
          var out = await _reportGetController.addSolutions(_commentController.text, this.issueId);
          if(out){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              showCloseIcon: true,
              title: "Success",
              btnOkOnPress: () => Get.to(AdminViewIssues()),
              desc: "Solution provided",

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
