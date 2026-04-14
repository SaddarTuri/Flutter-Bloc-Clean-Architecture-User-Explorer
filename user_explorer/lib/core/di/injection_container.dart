import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:user_explorer/data/datasources/auth/auth_local_data_source.dart';
import 'package:user_explorer/data/datasources/user_remote_data_source.dart';
import 'package:user_explorer/data/repositories/auth/auth_repository_impl.dart';
import 'package:user_explorer/data/repositories/user_repository_impl.dart';
import 'package:user_explorer/domain/repositories/auth/auth_repository.dart';
import 'package:user_explorer/domain/repositories/user_repository.dart';
import 'package:user_explorer/domain/usecases/auth/login_usecase.dart';
import 'package:user_explorer/domain/usecases/get_users_usecase.dart';
import 'package:user_explorer/presentation/bloc/auth/auth_bloc.dart';
import 'package:user_explorer/presentation/bloc/user/user_bloc.dart';

final GetIt sl = GetIt.instance;

/// Dependency injection setup:
/// Registers objects by layer so wiring stays centralized and scalable.
Future<void> initDependencies() async {
  // External client
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: const {
          'Accept': 'application/json',
          'User-Agent': 'UserExplorerApp/1.0',
        },
        // Let the data source handle 4xx/5xx cleanly.
        validateStatus: (status) => status != null && status < 600,
      ),
    ),
  );

  // Data layer
  sl.registerLazySingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl.new);
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthLocalDataSource>()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl<UserRemoteDataSource>()),
  );

  // Domain layer
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(sl<UserRepository>()),
  );

  // Presentation layer
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl<LoginUseCase>()),
  );
  sl.registerFactory<UserBloc>(
    () => UserBloc(sl<GetUsersUseCase>()),
  );
}
