import 'package:user_explorer/domain/entities/user.dart';

/// Domain contract:
/// Presentation and use cases depend on this abstraction only.
abstract class UserRepository {
  Future<List<User>> getUsers();
}
