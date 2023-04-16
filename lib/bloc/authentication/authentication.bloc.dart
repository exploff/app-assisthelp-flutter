import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication.event.dart';
part 'authentication.state.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  final AuthRepository authRepository;


  AuthenticationBloc({required this.authRepository})
    : super(AuthenticationUnitializedState()) {

      on((AppStartedEvent event, emit) async {
        final bool hasToken = await authRepository.hasToken();
        if (hasToken) {
          emit(AuthenticationAuthenticatedState());
        } else {
          emit(AuthenticationUnauthenticatedState());
        }
      });

      on((LoggedInEvent event, emit) async {
        emit(AuthenticationLoadingState());
        await authRepository.persisteToken(event.token, event.refreshToken);
        emit(AuthenticationAuthenticatedState());
      });
      
      on((LoggedOutEvent event, emit) async {
        emit(AuthenticationLoadingState());
        await authRepository.deleteToken();
        emit(AuthenticationUnauthenticatedState());
      });
  }

  @override
  AuthenticationState get initialState => AuthenticationUnitializedState();


}