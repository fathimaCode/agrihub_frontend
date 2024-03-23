import 'package:agrihub/Common/NavBar.dart';
import 'package:agrihub/controller/AgriInformationController.dart';
import 'package:agrihub/model/Agriculture.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Constant/agri_color.dart';

class AddAgriInfo extends StatelessWidget {
 AddAgriInfo({super.key});
 final AgriInformationController _agriInfoController = Get.put(AgriInformationController());
 final TextEditingController _titleController = TextEditingController();
 final TextEditingController _descriptionController = TextEditingController();
 final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),
      drawer: AdminNavBar(),
      body: SingleChildScrollView(
          child: Container(
            height: AgriColors.screenHeight(context),
            width: AgriColors.screenWidth(context),
            decoration: BoxDecoration(color: AgriColors.primaryColor),
            child: Column(children: [


              Expanded(
                child: Container(

                  height: AgriColors.screenHeight(context) * 0.8,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AgriColors.whiteColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AgriColors.whiteColor, style: BorderStyle.solid, width: 1)),
                  child: Column(

                    children: [
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(labelText: "title",border: OutlineInputBorder()),),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(),
                          ),
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _contentController,
                          decoration: InputDecoration(
                            labelText: "Content",
                            border: OutlineInputBorder(),
                          ),
                        ),

                      ),

                      ElevatedButton(onPressed: () async{

                        Agriculture agriModel= new Agriculture(id: "", title: _titleController.text, description: _descriptionController.text,
                            content: _contentController.text, date: "");
                        var out = await AgriInformationController().addAgriInfo(agriModel);
                        if(out){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "Success",
                            desc: "Agri Information added successfully",
                            btnOkColor: Colors.green,

                          ).show();
                          _titleController.text = "";
                          _descriptionController.text = "";
                          _contentController.text = "";

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

                      SizedBox(height: 10,),



                    ],),

                ),
              )
            ],),
          )
      ),);
  }
}
