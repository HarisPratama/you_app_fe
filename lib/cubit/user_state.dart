part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class UserLoading extends UserState {
  final String? action; // e.g., "updateProfile"

  const UserLoading({this.action});

  @override
  List<Object> get props => [action ?? ''];
}

class UserSuccess extends UserState {
  final UserModel user;
  final String? action; // e.g., "updateProfile"

  const UserSuccess(this.user, {this.action});

  @override
  List<Object> get props => [user, action ?? ''];
}

class UserFailed extends UserState {
  final String error;
  final String? action; // e.g., "updateProfile"

  const UserFailed(this.error, {this.action});

  @override
  List<Object> get props => [error, action ?? ''];
}
