import 'package:hive_flutter/hive_flutter.dart';
part 'db_model.g.dart';

String userdbName = 'UserDatabase';

@HiveType(typeId: 1)
class UserDb {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String verifyToken;

  @HiveField(3)
  final String role;

  @HiveField(4)
  final String token;

  @HiveField(5)
  final String id;

  UserDb(
      {required this.name,
      required this.email,
      required this.verifyToken,
      required this.role,
      required this.token, required this.id});
}

class UserDatabaseBox {
  static Box<UserDb>? _box;

  static Box<UserDb> getInstance() {
    return _box ??= Hive.box(userdbName);
  }
}
