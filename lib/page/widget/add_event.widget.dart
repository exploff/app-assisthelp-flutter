import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:app_assisthelp/page/form/field/datetime.field.dart';
import 'package:app_assisthelp/model/event.model.dart';


class AddEventWidget extends StatefulWidget {
  
  final void Function(CalendarEventData)? onEventAdd;
  final DateTime startDate;

  const AddEventWidget({super.key, this.onEventAdd, required this.startDate});

  @override
  State<AddEventWidget> createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  DateTime? _startTime;
  DateTime? _endTime;
  DateTime? _additionnalTime;

  String _title = "Journée de travail";

  late FocusNode _dateNode;

  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _additionnalTimeController;

  @override
  void initState() {
    super.initState();

    _dateNode = FocusNode();

    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
    _additionnalTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _dateNode.dispose();

    _startTimeController.dispose();
    _endTimeController.dispose();
    _additionnalTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ajouter une journée du travail pour le : ${widget.startDate.toString()}"),
            const SizedBox(
              height: 15,
            ),
            const Text("Enfant : Julien"),
            const SizedBox(
              height: 15
            ),
            Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _startTimeController,
                    validator: (value) {
                      if (value == null || value == "")
                        return "Choissisez une erreur de début.";

                      return null;
                    },
                    onSave: (date) => _startTime = date,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                    type: DateTimeSelectionType.time,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _endTimeController,
                    validator: (value) {
                      if (value == null || value == "")
                        return "Choissisez une heure de fin.";

                      return null;
                    },
                    onSave: (date) => _endTime = date,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                    type: DateTimeSelectionType.time,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                print("Ajouter une journée de travail");
                _createEvent();
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      );
  }


  void _createEvent() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    final event = CalendarEventData(
      date: widget.startDate,
      endTime: _endTime,
      startTime: _startTime,
      endDate: widget.startDate,
      title: _title,
      event: Event(
        title: _title,
      ),
    );

    widget.onEventAdd?.call(event);
    _resetForm();
  }

  void _resetForm() {
    _form.currentState?.reset();
    _endTimeController.text = "";
    _startTimeController.text = "";
  }
}