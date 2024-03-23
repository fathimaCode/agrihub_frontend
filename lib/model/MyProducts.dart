import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class MyProducts {
  final String title;
  final String quantity;
  final String originalquantity;
  final String subbtotal;
  final String image;





  MyProducts({
    required this.title,
    required this.subbtotal,
    required this.quantity,
    required this.originalquantity,
    required this.image,


  });


  factory MyProducts.fromJson(Map<String, dynamic> json) {
    return MyProducts(
      title: json['title'],
      image: json['img'],
       quantity: json['quantity'],
      originalquantity: json['originalquantity'],
       subbtotal: json['subtotal'],

    );
  }
}
