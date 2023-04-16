part of 'authentication.bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}


class AuthenticationUnitializedState extends AuthenticationState {}

class AuthenticationAuthenticatedState extends AuthenticationState {}

class AuthenticationUnauthenticatedState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}