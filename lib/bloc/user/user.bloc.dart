import 'package:app_assisthelp/model/user.model.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:app_assisthelp/repository/user.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exception/unauthorized.exception.dart';

part 'user.event.dart';
part 'user.state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  UserBloc({
    required this.userRepository,
    required this.authRepository
  }) : super(UserInitialState()) {
    on((UserFetchEvent event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await userRepository.getCurrentUser();
        emit(UserSuccessState(user: user));
      } catch (exception) {
        if (exception is UnauthorizedException) {

          try {
            var auth = await authRepository.refreshToken();
            final user = await userRepository.getCurrentUser();
            emit(UserSuccessState(user: user));
          } catch (exception) {
            print("FATAL ERROR : " + exception.toString());
            emit(UserFatalErrorState());
          }

        } else {
          emit(UserFailureState(errorMessage: exception.toString()));
        }
      }
    });

    on((UserSubmitEvent event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await userRepository.updateCurrentUser(event.user);
        emit(UserSuccessState(user: user));
      } catch (exception) {
        if (exception is UnauthorizedException) {

          try {
            var auth = await authRepository.refreshToken();
            final user = await userRepository.updateCurrentUser(event.user);
            emit(UserSuccessState(user: user));
          } catch (exception) {
            print("FATAL ERROR : " + exception.toString());
            emit(UserFailureState(errorMessage: exception.toString()));
          }

        } else {
          emit(UserFailureState(errorMessage: exception.toString()));
        }
      }
    });
  }
}