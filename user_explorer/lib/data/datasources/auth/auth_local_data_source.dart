import 'package:user_explorer/core/constants/app_strings.dart';

abstract class AuthLocalDataSource {
  Future<bool> login({
    required String email,
    required String password,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl();

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return email.trim() == AppStrings.staticEmail &&
        password == AppStrings.staticPassword;
  }
}
