class Agriculture{
  final String id;
  final String title;
  final String description;
  final String content;
  final String date;

  Agriculture({
    required this.id,
    required this.title,

    required this.description,
    required this.content,
    required this.date,


  });


  factory Agriculture.fromJson(Map<String, dynamic> json) {
    return Agriculture(
      id: json['agriid'],
      title: json['title'],
      description: json['description'],

      content: json['content'],

      date: json['created_at'],

    );
  }
}