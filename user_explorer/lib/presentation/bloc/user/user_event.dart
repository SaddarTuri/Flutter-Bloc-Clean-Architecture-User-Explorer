import 'package:equatable/equatable.dart';

/// Bloc events:
/// UI triggers these actions.
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {
  const FetchUsers();
}
