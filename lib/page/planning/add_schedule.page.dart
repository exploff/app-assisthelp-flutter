import 'package:app_assisthelp/model/event.model.dart';
import 'package:app_assisthelp/page/form/field/datetime.field.dart';
import 'package:app_assisthelp/util/date.extension.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../widget/add_event.widget.dart';

class AddSchedulePage extends StatefulWidget {

  final DateTime startDate;

  const AddSchedulePage({
    Key? key,
    required this.startDate,
  }) : super(key: key);

  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Schedule"),
      ),

      body: AddEventWidget(
        onEventAdd: context.pop,
        startDate: widget.startDate,
      )
    );
  }
}