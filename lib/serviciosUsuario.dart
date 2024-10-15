import 'dbAyuda.dart';
import 'modelos/usuario.dart';

class UserService {
  Future<void> registerUser(String username, String password) async {
    final db = await DBHelper.database;
    User user = User(username: username, password: password);
    await db.insert('usuarios', user.toMap());
  }

  Future<User?> loginUser(String username, String password) async {
    final db = await DBHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return User(
        id: maps.first['id'],
        username: maps.first['username'],
        password: maps.first['password'],
      );
    }
    return null;
  }
}
