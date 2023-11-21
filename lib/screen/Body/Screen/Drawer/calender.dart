import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/main/Event/view_event_details.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomborderappbar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late ValueNotifier<List<Eventmodel>> _selectedEvents =
      ValueNotifier(_getEventforDay(_selectedDay!));

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventforDay(_selectedDay!));
  }

  List<Eventmodel> _getEventforDay(DateTime day) {
    final DateFormat dateFormat = DateFormat('dd-MMMM-yyyy');
    return eventList.value.where((event) {
      DateTime eventDate = dateFormat.parse(event.startingDay);
      return eventDate.year == day.year &&
          eventDate.month == day.month &&
          eventDate.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            allowSnapshotting: false,
            fullscreenDialog: true,
            builder: (context) => const MainBottom(),
          ),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          actions: [],
          titleText: '',
          automaticallyImplyLeadingtitle: false,
          bottom: BottomBorderNull(),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TableCalendar(
                firstDay: DateTime(2000, 10, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                eventLoader: _getEventforDay,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(selectedDay, _selectedDay!)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _selectedEvents.value = _getEventforDay(selectedDay);
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                availableGestures: AvailableGestures.all,
                daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                    weekdayStyle: TextStyle(color: Colors.black)),
                weekendDays: const [DateTime.sunday],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ValueListenableBuilder<List<Eventmodel>>(
                valueListenable: _selectedEvents,
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const Center(
                      child: Text('No events on this day'),
                    );
                  }
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final data = value[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ViewEventDetails(eventModel: data),
                            ));
                          },
                          title: Text(
                            data.eventname,
                            style: readexPro(fontSize: 12),
                          ),
                          subtitle: Text(
                            data.location,
                            style: readexPro(fontSize: 12),
                          ),
                          trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  data.startingTime,
                                  style: readexPro(fontSize: 12),
                                ),
                                Text(
                                  data.clientname!,
                                  style: readexPro(fontSize: 12),
                                ),
                              ]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
