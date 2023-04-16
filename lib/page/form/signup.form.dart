import 'package:app_assisthelp/bloc/sign/sign.bloc.dart';
import 'package:app_assisthelp/page/signin.page.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  final AuthRepository authRepository;

  const SignUpForm({super.key, required this.authRepository});

  @override
  State<SignUpForm> createState() => _SignUpFormState(authRepository);
}

class _SignUpFormState extends State<SignUpForm> {

  final AuthRepository authRepository;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;

  bool obscureText = true;
  
  _SignUpFormState(this.authRepository);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    onSignUpSubmit() {
      BlocProvider.of<SignBloc>(context).add(
        SignUpSubmitEvent(
          username: _usernameController.text,
          email: _emailController.text, 
          password: _passwordController.text
        )
      );
    }


    return BlocListener<SignBloc, SignState>(
      listener: (context, state) {
        if (state is SignFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,)
            );        
        }
        if (state is SignUpSuccessState) {
          Navigator.pop(context);
        }

      },
      child: BlocBuilder<SignBloc,SignState>(builder: (context, state) {
        return Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text("Inscription"),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Adresse email",
                      hintText: "Adresse email",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 5))
                    ),
                    validator: (value) {
                      if (value == null || 
                          value.isEmpty || 
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Veuillez entrer une adresse email valide';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Pseudonyme",
                      hintText: "Pseudonyme",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pseudonyme';
                      } else if(value.length < 4) {
                        return 'Pseudonyme must be at least 4 characters';
                      }
                      return null;
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      hintText: "Mot de passe",
                      border: const OutlineInputBorder(borderSide: BorderSide(width: 5)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureText = !obscureText;
                        },
                        icon: const Icon(Icons.remove_red_eye)
                      ),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if(value.length < 5) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    obscureText: obscureText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: state is SignLoadingState ? 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: CircularProgressIndicator(),
                            )
                          ]
                        ),
                      )
                    ],
                  ) : ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        onSignUpSubmit();
                      }
                    },
                    child: const Text('Inscription'),
                  ),
                ),
              ],
            ),
          ),
        );
      })
    );
  }
}