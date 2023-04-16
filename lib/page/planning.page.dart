import 'package:app_assisthelp/model/event.model.dart';
import 'package:app_assisthelp/page/planning/add_schedule.page.dart';
import 'package:app_assisthelp/page/widget/delete_event.widget.dart';
import 'package:app_assisthelp/util/date.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:calendar_view/calendar_view.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {

  late final EventController _eventController;

  @override
  void initState() {
    super.initState();
    _eventController = EventController();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: _eventController..addAll(_events),
        child: WeekView(
          // eventTileBuilder: (date, events, boundry, start, end) {
          //     // Return your widget to display as event tile.
          //     return Text("Event" + events.first.event.toString());
          // },
          onDateTap: (date) {
            _addEvent(date);
           
          },
          onEventTap: (events, date) {
            _showBottomModal(context, events.first as CalendarEventData<Event>);
          },

          // fullDayEventBuilder: (events, date) {
          //     // Return your widget to display full day event view.
          //     return Container();
          // },
          showLiveTimeLineInAllDays: true, // To display live time line in all pages in week view.
          //width: 400, // width of week view.
          minDay: DateTime(1990),
          maxDay: DateTime(2050),
          heightPerMinute: 1, // height occupied by 1 minute time span.
          eventArranger: SideEventArranger(), // To define how simultaneous events will be arranged.
          onDateLongPress: (date) => print(date),
          startDay: WeekDays.monday, // To change the first day of the week.        
        ),
      );
  }

  Future<void> _addEvent(DateTime startDate) async {
    final event = await context.pushRoute<CalendarEventData<Event>>(
      AddSchedulePage(
        startDate: startDate,
      )
    );
    if (event == null) return;
    _eventController.add(event);
  }

  _showBottomModal(context, CalendarEventData<Event> event) async {
    final deleteEvent = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return DeleteEventWidget(
          event: event,
        );
      }
    );
    if (deleteEvent == null) return;
    _eventController.remove(deleteEvent);
  }
}

DateTime get _now => DateTime.now();
List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: Event(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
    CalendarEventData(
    date: _now.add(Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: Event(title: "Wedding anniversary"),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: Event(title: "Football Tournament"),
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
];