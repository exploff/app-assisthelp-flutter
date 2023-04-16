part of 'authentication.bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
} 


class AppStartedEvent extends AuthenticationEvent {}

class LoggedInEvent extends AuthenticationEvent {
  final String token;
  final String refreshToken;

  const LoggedInEvent({required this.token, required this.refreshToken});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Logged in {$token}';
}

class LoggedOutEvent extends AuthenticationEvent {}
