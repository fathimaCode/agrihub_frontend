import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String quantity;
  final String price;
  final MultipartFile  img;
  final String created_at;



  Product({
    required this.id,
    required this.title,
    required this.quantity,
    required this.description,
    required this.price,
    required this.img,
    required this.created_at,

  });


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
