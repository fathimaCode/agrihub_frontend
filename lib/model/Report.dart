class Report {
  final String id;
  final String comments;
  final String userid;
  final String response;
  final String createdAt;
  final String response_at;


  Report({
    required this.id,
    required this.comments,
    required this.userid,
    required this.response,
    required this.createdAt,
    required this.response_at,

  });


  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['issue_id'],
      comments: json['comments'],
      userid: json['userid'],
      response: json['response'],
      createdAt: json['created_at'],
      response_at: json['response_at'],

    );
  }
}
