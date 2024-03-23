class OrderAdminView{
  final String id;
  final String userid;
  final String purchaseid;
  final String purchased_at;
  final String status;
  final String delivery_at;
  OrderAdminView({
    required this.id,
    required this.userid,
    required this.purchaseid,
    required this.purchased_at,
    required this.status,
    required this.delivery_at,

  });


  factory OrderAdminView.fromJson(Map<String, dynamic> json) {
    return OrderAdminView(
      id: json['id'],
      userid: json['userid'],
      purchaseid: json['purchaseid'],
      purchased_at: json['purchased_at'],
      status: json['status'],
      delivery_at: json['delivery_at'],

    );
  }
}