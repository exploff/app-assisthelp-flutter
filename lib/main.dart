import 'package:app_assisthelp/bloc/authentication/authentication.bloc.dart';
import 'package:app_assisthelp/page/home.page.dart';
import 'package:app_assisthelp/page/intro.page.dart';
import 'package:app_assisthelp/page/signin.page.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SimpleBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
  
}
void main() {
  Bloc.observer = SimpleBlocObserver(); 
  final AuthRepository authRepository = AuthRepository();

  runApp(
    BlocProvider(
      create: (context) {
        return AuthenticationBloc(authRepository: authRepository)..add(AppStartedEvent());
      },
      child: MyApp(authRepository: authRepository,),
    )
  );
}

class MyApp extends StatelessWidget {

  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Assist Help',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
          if (state is AuthenticationAuthenticatedState) {
            return const Home();
          }
          if (state is AuthenticationUnauthenticatedState) {
            return IntroPage(authRepository: authRepository);
          }
          if (state is AuthenticationLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
    );
  }
}
