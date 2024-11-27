part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthLoginModel auth;

  AuthSuccess(this.auth);

  @override
  List<Object> get props => [auth];
}
class AuthSuccessRegister extends AuthState {
  final AuthRegisterModel auth;
  AuthSuccessRegister(this.auth);

  @override
  List<Object> get props => [auth];
}

class AuthFailed extends AuthState {
  final String error;

  AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}
