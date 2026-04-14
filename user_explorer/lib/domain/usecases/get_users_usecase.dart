import 'package:user_explorer/domain/entities/user.dart';
import 'package:user_explorer/domain/repositories/user_repository.dart';

/// Domain use case:
/// Encapsulates a single app action (fetch users).
class GetUsersUseCase {
  const GetUsersUseCase(this._repository);

  final UserRepository _repository;

  Future<List<User>> call() {
    return _repository.getUsers();
  }
}
