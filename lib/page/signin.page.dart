import 'package:app_assisthelp/bloc/authentication/authentication.bloc.dart';
import 'package:app_assisthelp/bloc/sign/sign.bloc.dart';
import 'package:app_assisthelp/page/signup.page.dart';
import 'package:app_assisthelp/page/form/signin.form.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  final AuthRepository authRepository;

  const SignIn({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: BlocProvider(create: (context) {
        return SignBloc(authRepository: authRepository, authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
      },
      child: Column(
        children: [
          SignInForm(authRepository: authRepository),
          GestureDetector(
            child: const Text("Pas encore de compte ?"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(authRepository: authRepository,)));
            },
          ),
        ],
      ),
      ),
    );
  }
}