import 'package:user_explorer/data/datasources/auth/auth_local_data_source.dart';
import 'package:user_explorer/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authLocalDataSource);

  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) {
    return _authLocalDataSource.login(email: email, password: password);
  }
}
