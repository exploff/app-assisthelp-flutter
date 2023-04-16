import 'package:app_assisthelp/bloc/authentication/authentication.bloc.dart';
import 'package:app_assisthelp/bloc/children/children.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_assisthelp/page/component/children.component.dart';
class ChildrenPage extends StatelessWidget {
  const ChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChildrenBloc, ChildrenState>(
      listener: (context, state) {
        if (state is ChildrenFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,)
            );        
        }
        if (state is ChildrenFatalErrorState) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            LoggedOutEvent()
          );
        }
      },

      child: BlocBuilder<ChildrenBloc, ChildrenState>(
        builder: (context, state) {
          if (state is ChildrenSuccessState) {
            print(state.childrens);
            return ListView.builder(
              itemCount: state.childrens.length,
              itemBuilder: (context, index) {
                return ChildrenComponent(children: state.childrens[index],);
              },
            );
          }
          if (state is ChildrenFatalErrorState || state is ChildrenFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Une erreur est survenue.'),
                  const Text('Veuillez vous reconnecter et réessayer'),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ChildrenBloc>(context).add(
                        ChildrensFetchEvent()
                      );
                    }, 
                    child: const Text('Retry')
                  )
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