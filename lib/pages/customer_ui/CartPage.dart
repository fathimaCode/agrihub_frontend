import 'package:agrihub/model/CartItem.dart';
import 'package:agrihub/pages/customer_ui/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrihub/routes/agriRoute.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/CustomerNavBar.dart';
import '../../Constant/agri_color.dart';
import '../../controller/ProductController.dart';
import '../../model/FarmerProduct.dart';

class CartPage extends StatelessWidget {
  final FarmerProduct productItem;

  CartPage({Key? key, required this.productItem}) : super(key: key);
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    _productController.quantity.value = 1;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            _productController.initalRefreshFunctions();
          }, icon: Icon(Icons.add_shopping_cart,color: AgriColors.primaryColor,))],
        title: Text("Product Details"),
      ),
      drawer: CustomerNavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: Image.network(
                    agriRoute.imageUrl + productItem.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                productItem.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                productItem.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "OMR: ${productItem.price}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        var totalQuantity = int.parse(productItem.quantity);

                        if(_productController.quantity.value>totalQuantity){

                          Get.snackbar("Sorry", "Total Quantity of this product is ${totalQuantity}",backgroundColor: Colors.red, colorText: Colors.white);
                        }
                        else{
                          _productController.quantity.value += 1;
                          _productController.subtotal.value =  _productController.quantity.value* int.parse(productItem.price);
                        }

                      },
                      icon: Icon(Icons.add),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 10,
                        child: Obx(() => Text(_productController.quantity.value.toString())),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _productController.quantity.value -= 1;
                        _productController.subtotal.value =  _productController.quantity.value* int.parse(productItem.price);
                        print(_productController.subtotal.value);
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
              Obx(() => Text("Sub Total: OMR ${_productController.subtotal.value.toString()}")),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async{
                    var userInfo=await SharedPreferences.getInstance();
                    var userid = userInfo.getString("userId")!;

                    CartItem cart = new CartItem(pid: productItem.id, subbtotal: _productController.subtotal.value, quantity:  _productController.quantity.value, userid: userid, created_at: "");
                    var out =await _productController.addCart(cart);
                    if(out){
                      Get.snackbar("Success", "Product Added to Cart",snackPosition: SnackPosition.TOP,backgroundColor: AgriColors.primaryColor,colorText: AgriColors.whiteColor);
                      Future.delayed(Duration(seconds: 2), () {
                        Get.off(Customerdashboard());
                      });
                    }
                    else{
                      Get.snackbar("Error", "Something Went Wrong",snackPosition: SnackPosition.TOP);
                    }
                  },
                  child: Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
