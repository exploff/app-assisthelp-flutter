part of 'user.bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserFetchEvent extends UserEvent {
  const UserFetchEvent();

  @override
  List<Object> get props => [];
}


class UserSubmitEvent extends UserEvent {
  final User user;

  const UserSubmitEvent({
    required this.user});

  @override
  List<Object> get props => [];
}