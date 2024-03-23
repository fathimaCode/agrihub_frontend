import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class FarmerProduct {
  final String id;
  final String title;
  final String description;
  final String quantity;
  final String price;
  final String  img;
  final String created_at;



  FarmerProduct({
    required this.id,
    required this.title,
    required this.quantity,
    required this.description,
    required this.price,
    required this.img,
    required this.created_at,

  });


  factory FarmerProduct.fromJson(Map<String, dynamic> json) {
    return FarmerProduct(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
      img: json['img'],
      created_at: json['created_at'],

    );
  }
}
