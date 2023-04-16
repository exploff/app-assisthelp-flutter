part of 'sign.bloc.dart';

abstract class SignEvent extends Equatable {
  const SignEvent();
}

class SignUpSubmitEvent extends SignEvent {
  final String email;
  final String password;
  final String username;

  const SignUpSubmitEvent({
    required this.email,
    required this.password,
    required this.username
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignUpSubmitEvent {email: $email, password: $password}';
}

class SignInSubmitEvent extends SignEvent {
  final String email;
  final String password;

  const SignInSubmitEvent({
    required this.email,
    required this.password
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignInSubmitEvent {email: $email, password: $password}';
}