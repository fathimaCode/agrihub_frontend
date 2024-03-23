class User {
  final String id;
  final String username;
  final String email;
  final String contact;
  final String mode;

  final String createdAt;
  final String password;
  final String approved;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.contact,
    required this.createdAt,
    required this.password,
    required this.mode,
    required this.approved,
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['name'],
      email: json['email'],
      mode: json['mode'],
      contact: json['contact'],
      createdAt: json['created_at'],
      password: json['password'],
      approved: json['approved'],
    );
  }
}
