part of 'sign.bloc.dart';

abstract class SignState extends Equatable {

  const SignState();

  @override
  List<Object> get props => [];
}

class SignInitialState extends SignState {}

class SignLoadingState extends SignState {}

class SignUpSuccessState extends SignState{}

class SignFailureState extends SignState {
  final String errorMessage;

  const SignFailureState({required this.errorMessage});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginFailure {$errorMessage}';
}