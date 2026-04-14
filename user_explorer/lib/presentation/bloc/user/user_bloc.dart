import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_explorer/domain/usecases/get_users_usecase.dart';
import 'package:user_explorer/presentation/bloc/user/user_event.dart';
import 'package:user_explorer/presentation/bloc/user/user_state.dart';

/// Presentation layer bloc:
/// Coordinates use cases and emits UI-friendly states.
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._getUsersUseCase) : super(const UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  final GetUsersUseCase _getUsersUseCase;

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(const UserLoading());
    try {
      final users = await _getUsersUseCase();
      emit(UserLoaded(users));
    } catch (error) {
      final message = error.toString().replaceFirst('Exception: ', '');
      emit(UserError(message));
    }
  }
}
