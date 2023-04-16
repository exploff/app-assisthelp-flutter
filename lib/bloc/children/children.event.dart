part of 'children.bloc.dart';

abstract class ChildrenEvent extends Equatable {
  const ChildrenEvent();
}

class ChildrensFetchEvent extends ChildrenEvent {
  const ChildrensFetchEvent();

  @override
  List<Object> get props => [];
}


class ChildrenSubmitEvent extends ChildrenEvent {

  @override
  List<Object> get props => [];
}