import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class TrackOrders {
  final String purchaseid;
  final String purchased_at;
  final String status;
  final String delivery_at;
  final String quantity;
  final String  subtotal;
  final String pid;
  final String title;
  final String img;



  TrackOrders({
    required this.purchaseid,
    required this.purchased_at,
    required this.status,
    required this.delivery_at,
    required this.quantity,
    required this.img,
    required this.pid,
    required this.subtotal,
    required this.title,

  });


  factory TrackOrders.fromJson(Map<String, dynamic> json) {
    return TrackOrders(
      purchaseid: json['purchaseid'],
      purchased_at: json['purchased_at'],
      status: json['status'],
      delivery_at: json['delivery_at'],
      quantity: json['quantity'],
      img: json['img'],
      subtotal: json['subtotal'],
        pid: json['pid'],
        title: json['title']

    );
  }
}
