class User {
  final String? id;
  final String email;
  final String password;

  User({
    this.id,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}