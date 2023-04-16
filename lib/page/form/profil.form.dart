import 'package:app_assisthelp/bloc/user/user.bloc.dart';
import 'package:app_assisthelp/model/user.model.dart';
import 'package:app_assisthelp/page/form/field/datetime.field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilForm extends StatefulWidget {
  
  final User user;
  
  const ProfilForm({required this.user, super.key});

  

  @override
  State<ProfilForm> createState() => _ProfilFormState();
}

class _ProfilFormState extends State<ProfilForm> {

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthdayDateController;

  late TextEditingController _indemniteController;
  
  late TextEditingController _descriptionProfilController;

  // late TextEditingController _phoneController;

  // late TextEditingController _addressController;
  // late TextEditingController _cityController;
  // late TextEditingController _zipController;
  // late TextEditingController _countryController;
  

  
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _birthdayDateController = TextEditingController();
    _indemniteController = TextEditingController();
    _descriptionProfilController = TextEditingController();

    _firstNameController.text = widget.user.firstName!;
    _lastNameController.text = widget.user.lastName!;
    _birthdayDateController.text = widget.user.birthdayDate!;
    _indemniteController.text = widget.user.indemnite.toString();
    _descriptionProfilController.text = widget.user.description!;

  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayDateController.dispose();
    _indemniteController.dispose();
    _descriptionProfilController.dispose();
    super.dispose();
  }

  void onProfilSubmit() {

     BlocProvider.of<UserBloc>(context).add(
        UserSubmitEvent(
          user: User(
            id: widget.user.id,
            username: widget.user.username,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            birthdayDate: _birthdayDateController.text,
            indemnite: double.parse(_indemniteController.text),
            description: _descriptionProfilController.text,
          )
        )
      );

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Profil", style: TextStyle(fontSize: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "Prénom",
                      hintText: "Prénom",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 5))
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "Nom",
                      hintText: "Nom",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 5))
                    )
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: DateTimeSelectorFormField(
                controller: _birthdayDateController,
                //onSave: (date) => _startTime = date,
                decoration: const InputDecoration(
                  labelText: "Date de naissance",
                  hintText: "01/01/2000",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5))
                ),
                type: DateTimeSelectionType.date,
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _descriptionProfilController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Ma description...",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5))
                )
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _indemniteController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Prix de l'indemnité",
                  hintText: "0.00",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5))
                )
              ),
            ),
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  onProfilSubmit();
                }
              },
              child: const Text('Valider'),
            ), 
          )
        ],
      ),
    );
  }
}