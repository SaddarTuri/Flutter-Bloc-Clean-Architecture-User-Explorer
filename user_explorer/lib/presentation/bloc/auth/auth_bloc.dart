import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/domain/usecases/auth/login_usecase.dart';
import 'package:user_explorer/presentation/bloc/auth/auth_event.dart';
import 'package:user_explorer/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._loginUseCase) : super(const AuthState(isAuthenticated: false)) {
    on<LoginRequested>(_onLoginRequested);
  }

  final LoginUseCase _loginUseCase;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final success = await _loginUseCase(
      email: event.email,
      password: event.password,
    );
    if (success) {
      emit(const AuthState(isAuthenticated: true));
      return;
    }
    emit(
      const AuthState(
        isAuthenticated: false,
        errorMessage: AppStrings.invalidCredentials,
      ),
    );
  }
}
