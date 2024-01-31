part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState with EquatableMixin{
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}

class UserLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends AuthState with EquatableMixin{
  final UserModel userModel;

  UserLoaded(this.userModel);
  @override
  List<Object?> get props => [userModel];
}

class UserError extends AuthState with EquatableMixin{
  final String error;

  UserError(this.error);
  @override
  List<Object?> get props => [error];
}
