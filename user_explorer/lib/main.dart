import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_explorer/core/constants/app_colors.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/core/di/injection_container.dart';
import 'package:user_explorer/presentation/bloc/auth/auth_bloc.dart';
import 'package:user_explorer/presentation/bloc/auth/auth_state.dart';
import 'package:user_explorer/presentation/bloc/theme/theme_bloc.dart';
import 'package:user_explorer/presentation/bloc/theme/theme_state.dart';
import 'package:user_explorer/presentation/bloc/user/user_bloc.dart';
import 'package:user_explorer/presentation/pages/auth/login_page.dart';
import 'package:user_explorer/presentation/pages/main_navigation_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const UserExplorerApp());
}

class UserExplorerApp extends StatelessWidget {
  const UserExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<UserBloc>()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              scaffoldBackgroundColor: AppColors.scaffoldLight,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              scaffoldBackgroundColor: AppColors.scaffoldDark,
              useMaterial3: true,
            ),
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState.isAuthenticated) {
                  return const MainNavigationPage();
                }
                return const LoginPage();
              },
            ),
          );
        },
      ),
    );
  }
}
