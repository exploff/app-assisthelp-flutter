part of 'children.bloc.dart';

abstract class ChildrenState extends Equatable {
  const ChildrenState();

  @override
  List<Object> get props => [];
}

class ChildrenInitialState extends ChildrenState {
  //TODO : check le token ?
}

class ChildrenLoadingState extends ChildrenState {}

class ChildrenSuccessState extends ChildrenState {
  final List<Children> childrens;

  const ChildrenSuccessState({required this.childrens});

  @override
  List<Object> get props => [childrens];
}

class ChildrenFatalErrorState extends ChildrenState {}


class ChildrenFailureState extends ChildrenState {
  final String errorMessage;

  const ChildrenFailureState({required this.errorMessage});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ChildrenFailure {$errorMessage}';
}
