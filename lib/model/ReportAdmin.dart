class ReportAdmin {
  final String id;
  final String comments;
  final String username;
  final String response;
  final String createdAt;
  final String response_at;


  ReportAdmin({
    required this.id,
    required this.comments,
    required this.username,
    required this.response,
    required this.createdAt,
    required this.response_at,

  });


  factory ReportAdmin.fromJson(Map<String, dynamic> json) {
    return ReportAdmin(
      id: json['issue_id'],
      comments: json['comments'],
      username: json['name'],
      response: json['response'],
      createdAt: json['created_at'],
      response_at: json['response_at'],

    );
  }
}
