import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class MyCart {
  final String title;
  final String quantity;
  final String subbtotal;
  final String image;
  final String created_at;




  MyCart({
    required this.title,
    required this.subbtotal,
    required this.quantity,
    required this.image,
    required this.created_at,

  });


  factory MyCart.fromJson(Map<String, dynamic> json) {
    return MyCart(
      title: json['title'],
      image: json['image'],
       quantity: json['quantity'],
      created_at: json['created_at'], subbtotal: json['subtotal'],

    );
  }
}
