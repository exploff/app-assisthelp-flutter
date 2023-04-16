import 'package:app_assisthelp/bloc/authentication/authentication.bloc.dart';
import 'package:app_assisthelp/bloc/user/user.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:app_assisthelp/page/form/profil.form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,)
            );        
        }
        if (state is UserFatalErrorState) {
          print("FATAL ERROR");
          BlocProvider.of<AuthenticationBloc>(context).add(
            LoggedOutEvent()
          );
        }
      },

      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserSuccessState) {
            return Container(
              child: ProfilForm(user: state.user,)
            );
          }
          if (state is UserFatalErrorState || state is UserFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Une erreur est survenue.'),
                  Text('Veuillez vous reconnecter et réessayer'),
                ],
              ),

            );
          }
          return const Center(
              child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}