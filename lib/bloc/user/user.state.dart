part of 'user.bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {
  //TODO : check le token ?
}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final User user;

  const UserSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class UserFatalErrorState extends UserState {}


class UserFailureState extends UserState {
  final String errorMessage;

  const UserFailureState({required this.errorMessage});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'UserFailure {$errorMessage}';
}
