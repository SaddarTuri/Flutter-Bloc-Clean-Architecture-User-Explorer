import 'package:user_explorer/data/datasources/user_remote_data_source.dart';
import 'package:user_explorer/domain/entities/user.dart';
import 'package:user_explorer/domain/repositories/user_repository.dart';

/// Data repository implementation:
/// Bridges domain contracts with concrete data sources.
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  Future<List<User>> getUsers() {
    return _remoteDataSource.getUsers();
  }
}
