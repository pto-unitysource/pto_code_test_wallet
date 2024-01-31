part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GoogleSignInRequested extends AuthEvent {}

class SaveUserRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

class LoadUser extends AuthEvent {
  final bool networkStatus;

  LoadUser(this.networkStatus);
}
