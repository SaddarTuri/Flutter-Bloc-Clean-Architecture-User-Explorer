import 'package:equatable/equatable.dart';
import 'package:user_explorer/domain/entities/user.dart';

/// Bloc states:
/// Represent UI state transitions.
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  const UserLoaded(this.users);

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

class UserError extends UserState {
  const UserError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
