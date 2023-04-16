import 'package:app_assisthelp/model/children.model.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:app_assisthelp/repository/children.repository.dart';
import 'package:app_assisthelp/repository/user.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exception/unauthorized.exception.dart';

part 'children.event.dart';
part 'children.state.dart';

class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final ChildrenRepository childrenRepository;

  ChildrenBloc({
    required this.userRepository,
    required this.authRepository,
    required this.childrenRepository
  }) : super(ChildrenInitialState()) {
    on((ChildrensFetchEvent event, emit) async {
      print("ChildrensFetchEvent");

      emit(ChildrenLoadingState());
      try {
        print("ChildrensFetchEvent");
        final childrens = await childrenRepository.getCurrentChildrens();
        emit(ChildrenSuccessState(childrens: childrens));
      } catch (exception) {
        if (exception is UnauthorizedException) {
          try {
            var auth = await authRepository.refreshToken();
            final childrens = await childrenRepository.getCurrentChildrens();
            emit(ChildrenSuccessState(childrens: childrens));
          } catch (exception) {
            print("FATAL ERROR : $exception");
            emit(ChildrenFatalErrorState());
          }
        } else {
          emit(ChildrenFailureState(errorMessage: exception.toString()));
        }
      }
    });
  }
}