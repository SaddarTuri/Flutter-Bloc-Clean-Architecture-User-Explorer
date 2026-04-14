import 'package:dio/dio.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/data/models/user_model.dart';

/// Data source:
/// Handles remote API calls and JSON parsing only.
abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _dio.get(
        AppStrings.usersApiUrl,
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 403) {
          throw Exception(
            'Access denied by server (403). Please try again on a different network or VPN.',
          );
        }
        throw Exception(
          'Unable to fetch users (HTTP ${response.statusCode}).',
        );
      }

      if (response.data is! List) {
        throw Exception('Invalid users payload received');
      }

      final usersJson = response.data as List<dynamic>;
      return usersJson
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      throw Exception(
        'Failed to load users: ${error.message ?? 'unknown network error'}',
      );
    }
  }
}
