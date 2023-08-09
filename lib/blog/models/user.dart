class User {
  final String email;
  final String password;
  final int id;

  User({
    required this.id,
    required this.email,
    required this.password,
  });

  User copyWith({
    String? name,
    String? password,
    String? id,
  }) {
    return User(
      id: this.id,
      email: name ?? email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'id=$id name=$email';
  }
}
