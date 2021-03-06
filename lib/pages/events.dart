//MIT License
//Copyright (c) 2018 Taylor Smith

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mac_mobile_attempt/helpers/event_API.dart';
import 'package:mac_mobile_attempt/helpers/calendar_view.dart';

/*
This file initializes the list of events and maps each event to a certain date
on the calendar. It also uses the calendar helpers to build the events tap widget
which appears on the application.
 */

class EventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventPageStateful();
  }
}

class EventPageStateful extends State<EventsPage> {
  int _counter = 0;

  StreamController<List<Map<String, String>>> eventsController =
      new StreamController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void dispose() {
    eventsController.close();
    super.dispose();
  }


  static String getMonth(Event event, bool start) {
    //Returns the month of an event date.
    EventDateTime time;
    if (start == true) {
      time = event.start;
    } else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.month > 9) {
        return time.dateTime.month.toString();
      } else {
        return "0" + time.dateTime.month.toString();
      }
    } else {
      if (time.date.month > 9) {
        return time.date.month.toString();
      } else {
        return "0" + time.date.month.toString();
      }
    }
  }

  static String getDay(Event event, bool start) {
    //Returns the day of an event date.
    EventDateTime time;
    if (start == true) {
      time = event.start;
    } else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.hour > 5 ) {
        if (time.dateTime.day > 9) {
          return time.dateTime.day.toString();
        } else {
          return "0" + time.dateTime.day.toString();
        }
      } else {
        int newDay = time.dateTime.day - 1;
        if (newDay > 9) {
          return newDay.toString();
        } else {
          return "0" + newDay.toString();
        }
      }
    }
    else {

        if (time.date.day > 9) {
          return time.date.day.toString();
        } else {
          return "0" + time.date.day.toString();
        }
    }
  }

  static String getYear(Event event, bool start) {
    //Returns the year of an event date.
    EventDateTime time;
    if (start == true) {
      time = event.start;
    } else {
      time = event.end;
    }
    if (time.dateTime != null) {
      return time.dateTime.year.toString();
    } else {
      return time.date.year.toString();
    }
  }

  static String getHour(Event event, bool start) {
    //Adjusts the time from the API to USA Central Time.
    EventDateTime time;
    if (start == true) {
      time = event.start;
    } else {
      time = event.end;
    }
    if (time.dateTime != null) {
       if (time.dateTime.hour == 0){
        return "18";
      }
      else if (time.dateTime.hour == 1) {
        return "19";
      } else if (time.dateTime.hour == 2) {
        return "20";
      } else if (time.dateTime.hour == 3) {
        return "21";
      } else if (time.dateTime.hour == 4) {
        return "22";
      } else if (time.dateTime.hour == 5) {
        return "23";
      } else if (time.dateTime.hour > 15) {
        int hour = time.dateTime.hour - 6;
        return hour.toString();
      } else {
        int hour2 = time.dateTime.hour - 6;
        return "0" + hour2.toString();
      }
    } else {
      if (time.date.hour == 0) {
        return "0" + time.date.hour.toString();
      } else if (time.date.hour == 0){
        return "18";
      }
      else if (time.date.hour == 1) {
        return "19";
      } else if (time.date.hour == 2) {
        return "20";
      } else if (time.date.hour == 3) {
        return "21";
      } else if (time.date.hour == 4) {
        return "22";
      } else if (time.date.hour == 5) {
        return "23";
      } else if (time.date.hour > 15) {
        int hour3 = time.date.hour - 6;
        return hour3.toString();
      } else {
        int hour4 = time.date.hour - 6;
        return "0" + hour4.toString();
      }
    }
  }

  static String getMinute(Event event, bool start) {
    //Returns the minutes of an event date.
    EventDateTime time;
    if (start == true) {
      time = event.start;
    } else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.minute > 9) {
        return time.dateTime.minute.toString();
      } else {
        return "0" + time.dateTime.minute.toString();
      }
    } else {
      if (time.date.minute > 9) {
        return time.date.minute.toString();
      } else {
        return "0" + time.date.minute.toString();
      }
    }
  }

  static String getSecond(Event event, bool start) {
    //Returns the seconds of an event date.
    EventDateTime time;
    if (start == true) {
      time = event.start;
    } else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.second > 9) {
        return time.dateTime.second.toString();
      } else {
        return "0" + time.dateTime.second.toString();
      }
    } else {
      if (time.date.second > 9) {
        return time.date.second.toString();
      } else {
        return "0" + time.date.second.toString();
      }
    }
  }

  static String getDateFormat(Event event, bool start) {
    //Returns the date in the format necessary to be mapped to a date and time in the calendar.
    return getYear(event, start) +
        "-" +
        getMonth(event, start) +
        "-" +
        getDay(event, start) +
        " " +
        getHour(event, start) +
        ":" +
        getMinute(event, start) +
        ":" +
        getSecond(event, start);
  }

  static List<Map<String, String>> getEventList() {
    bool duplicate = false;
    List<Map<String, String>> listOfEvents = [];
    List<Event> originalEvents = EventApi.getAllEvents();
    for (int i = 0; i < originalEvents.length; i++) {
      for (int z = 0; z < listOfEvents.length; z++) {
        if (listOfEvents[z]['name'] == originalEvents[i].summary &&
            listOfEvents[z]['date'] == getDateFormat(originalEvents[i], true)) {
          duplicate = true;
        }
      }
      if (duplicate == false) {
        listOfEvents.add({
          'name': originalEvents[i].summary,
          'location': originalEvents[i].location,
          'date': getDateFormat(originalEvents[i], true),
          'description': originalEvents[i].description,
          'end': getDateFormat(originalEvents[i], false)
        });
      }
      duplicate = false;
    }

    return listOfEvents;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> eventList = getEventList();

    eventsController.add(eventList);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child:AppBar(
        // Title
        title: Text("Events", style: TextStyle(fontSize: 20),),
        centerTitle: true,
        // Set the background color of the App Bar
        backgroundColor : Color(0xFF501426A).withOpacity(1),),),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // default String parameter values used below as example
            new CalendarView(
              titleField: 'name',
              detailField: 'location',
              dateField: 'date',
              endTime: 'end',
              desField: 'description',
              separatorTitle: 'Events',
              eventStream: eventsController.stream,
            ),
          ],
        ),
      ),
    );
  }
}
