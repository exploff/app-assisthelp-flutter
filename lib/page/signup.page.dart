import 'package:app_assisthelp/bloc/authentication/authentication.bloc.dart';
import 'package:app_assisthelp/bloc/sign/sign.bloc.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_assisthelp/page/form/signup.form.dart';

class SignUp extends StatelessWidget {

 final AuthRepository authRepository;

  const SignUp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
      ),
      body: BlocProvider(create: (context) {
        return SignBloc(authRepository: authRepository, authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
      },
        child: Column(
          children: [
            SignUpForm(authRepository: authRepository),
            GestureDetector(
              child: const Text("Déjà un compte ?"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ]
        ),
      ),
    );
  }
}