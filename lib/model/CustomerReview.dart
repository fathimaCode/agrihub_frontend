class CustomerReview {
  final String comments;
  final String created_at;
  final String name;



  CustomerReview({
    required this.comments,
    required this.created_at,
    required this.name,


  });


  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      comments: json['comments'],
      created_at: json['created_at'],
      name: json['name'],


    );
  }
}
