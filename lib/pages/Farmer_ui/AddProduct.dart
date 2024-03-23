

import 'dart:io';
import 'package:agrihub/pages/Farmer_ui/ViewProduct.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:agrihub/controller/ProductController.dart';
import 'package:flutter/material.dart';
import 'package:agrihub/Constant/agri_color.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../Common/FarmerNavBar.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);
  final ProductController _productController =   Get.put(ProductController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      drawer: FarmerNavBar(),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AgriColors.whiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AgriColors.whiteColor,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(children: [

                  Obx(() {
                    // Use Obx to reactively update UI when filePath value changes
                    final filePath = _productController.filePath.value;
                    return filePath != null
                        ? Padding(
                      padding: EdgeInsets.all(8),
                        child: Image.file(filePath,width: 250,height: 150,)) // Display the image if filePath is not null
                        : Text("No Image Selected");
                  }),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(icon: Icon(Icons.search),tooltip: 'Search',onPressed: () async{
                      await _productController.chooseImage();
                    },),
                  )
                ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    var userInfo=await SharedPreferences.getInstance();
                    var userId = userInfo.getString("userId");

                    if (_productController.filePath.value != null) {
                      File imageFile = _productController.filePath.value!;
                      String fileName = imageFile.path.split('/').last;

                      var request = http.MultipartRequest('POST', Uri.parse(agriRoute.productUrl));
                      request.fields['title'] = _titleController.text;
                      request.fields['quantity'] = _quantityController.text;
                      request.fields['description'] = _descriptionController.text;
                      request.fields['price'] = _priceController.text;
                      request.fields['userid'] = userId!;
                      request.fields['add_product'] = '1';

                      var imageStream = http.ByteStream(imageFile.openRead());
                      var length = await imageFile.length();
                      var multipartFile = http.MultipartFile('image', imageStream, length, filename: fileName);
                      request.files.add(multipartFile);
                      try {

                        var response = await http.Response.fromStream(await request.send());

                        print(response.body);
                        if(response.body=="1"){
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "Success",
                            desc: "${_titleController.text} added Successfully",
                            btnOkColor: Colors.green,
                            btnOkOnPress: () => Get.to(ViewProduct()),
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
                            btnOkOnPress: () => Get.to(AddProduct()),
                          ).show();
                        }
                      } catch (e) {
                        print('Error adding product: $e');
                      }
                    }
                    else {
                      // Show error message or handle case when no image is selected
                      print('No image selected!');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AgriColors.primaryColor,
                    foregroundColor: AgriColors.whiteColor,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width / 2,
                      50,
                    ),
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
