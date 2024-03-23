import 'package:agrihub/Constant/agri_color.dart';
import 'package:agrihub/controller/AuthenticationController.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/NavBar.dart';

class ViewFarmer extends StatelessWidget {
  ViewFarmer({super.key});
  final AuthenticationController _authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Farmer"),),
      drawer: AdminNavBar(),
      body: Obx(
            () {
          final farmerUsers = _authenticationController.farmerUsers;

          if (farmerUsers.isEmpty) {
            return Center(
              child: Text("No Farmer List"),
            );
          }

          return ListView.builder(
            itemCount: farmerUsers.length,
            itemBuilder: (context, index) {
              final farmerUser = farmerUsers[index];
              return Card(
                child: ListTile(
                  title: Text(farmerUser.username),
                  subtitle: Text(farmerUser.email),
                  trailing: farmerUser.approved == "0" || farmerUser.approved ==""
                    ? ElevatedButton(
                    onPressed: () async{
                      var out = await _authenticationController.approveFarmer(farmerUser.id);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "Success",
                        desc: "Account Created Successfully",
                        btnOkColor: Colors.green,

                      ).show();
                    },
                    child: Text("Approved"),
                  )
                      : Text(
                    "Approved",
                    style: TextStyle(color: AgriColors.primaryColor),
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
