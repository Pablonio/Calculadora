class User {
  final String username;
  final String password;
  final String role;

  User({required this.username, required this.password, required this.role});
}

List<User> users = [
  User(username: "admin", password: "1234", role: "admin"),
  User(username: "moderator", password: "1234", role: "moderator"),
  User(username: "user", password: "1234", role: "user"),
];
