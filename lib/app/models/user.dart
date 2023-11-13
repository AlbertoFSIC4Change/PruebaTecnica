

class User{
  User({
    required this.email,
    this.userId,
    this.role,
  });

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    final String? email = data['email'];
    final String? userId = data['userId'];
    final String? role = data['role'];

    return User(
      email: email,
      userId: userId,
      role: role,
    );
  }

  final String? email;
  final String? userId;
  final String? role;
}