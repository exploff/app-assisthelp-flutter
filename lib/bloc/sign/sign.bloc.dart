import 'package:app_assisthelp/bloc/authentication/authentication.bloc.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sign.state.dart';
part 'sign.event.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;
  
  SignBloc({
    required this.authRepository,
    required this.authenticationBloc
  }) : super(SignInitialState()) {
    on((SignInSubmitEvent event, emit) async {
      emit(SignLoadingState());
      try {
        final authentication = await authRepository.login(event.email, event.password);

        authenticationBloc.add(LoggedInEvent(token: authentication.token!, refreshToken: authentication.refreshToken!));

        emit(SignInitialState());
      } catch (exception) {        
        emit(SignFailureState(errorMessage: exception.toString()));
      }
    });
    on((SignUpSubmitEvent event, emit) async {
      emit(SignLoadingState());
      try {
        final authentication = await authRepository.register(event.username, event.email, event.password);
        authenticationBloc.add(LoggedInEvent(token: authentication.token!, refreshToken: authentication.refreshToken!));
        emit(SignUpSuccessState());
      } catch (exception) {
        emit(SignFailureState(errorMessage: exception.toString()));
      }
    });
  }

  @override
  SignState get initialState => SignInitialState();

}

