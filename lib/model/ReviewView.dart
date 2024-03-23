class ReviewView {
  final String pid;
  final String userId;
  final String comments;



  ReviewView({
    required this.pid,
    required this.userId,
    required this.comments,


  });


  factory ReviewView.fromJson(Map<String, dynamic> json) {
    return ReviewView(
      pid: json['pid'],
      userId: json['userId'],
      comments: json['comments'],


    );
  }
}
