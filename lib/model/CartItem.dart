import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class CartItem {
  final String pid;
  final int quantity;
  final int subbtotal;
  final String userid;
  final String created_at;



  CartItem({
    required this.pid,
    required this.subbtotal,
    required this.quantity,
    required this.userid,
    required this.created_at,

  });


  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      pid: json['pid'],
      userid: json['userid'],
       quantity: json['quantity'],
      created_at: json['created_at'], subbtotal: json['subbtotal'],

    );
  }
}
