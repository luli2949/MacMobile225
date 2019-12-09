import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/calendar/v3.dart' as prefix1;
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:mac_mobile_attempt/pages/eventsView.dart';
import 'multiSelectChip.dart';
import 'eventAPI.dart';
import 'calendarView.dart';
import 'calendarView.dart';
import 'eventsView.dart';


class EventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //print(EventCreate.allEvents().length);
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
  
//  static String getDateProper(Event event){
//    String date1 = time.date.year.toString()
//        + "-" + time.date.month.toString()
//        + "-" + time.date.day.toString() + "  ";
//    String time1 = time.date.hour.toString() + ":" +
//        time.date.minute.toString() + ":"
//    + time.date.second.toString();
//    return date1 + time1;
//  }


  static String getMonth(Event event, bool start) {
    EventDateTime time;
    if (start == true){
      time = event.start;
    }
    else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.month > 9) {
        return time.dateTime.month.toString();
      } else {
        return "0" + time.dateTime.month.toString();
      }
    }
    else {
        if (time.date.month > 9) {
          return time.date.month.toString();
        } else {
          return "0" + time.date.month.toString();
        }
      }
    }


  static String getDay(Event event, bool start) {
    EventDateTime time;
    if (start == true){
      time = event.start;
    }
    else {
      time = event.end;
    }
    if (time.dateTime != null) {
      
      if (time.dateTime.day > 9) {
        return time.dateTime.day.toString();
      } else {
        return "0" + time.dateTime.day.toString();
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
    EventDateTime time;
    if (start == true){
      time = event.start;
    }
    else {
      time = event.end;
    }
    if (time.dateTime != null) {
      return time.dateTime.year.toString();
    }
    else {
     return time.date.year.toString();
    }
  }

  static String getHour(Event event, bool start) {
    EventDateTime time;
    if (start == true){
      time = event.start;
    }
    else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.hour == 0){
        return "0" + time.dateTime.hour.toString();
      } else if (time.dateTime.hour == 1){
        return "19";
      } else if (time.dateTime.hour == 2){
        return "20";
      } else if (time.dateTime.hour == 3) {
        return "21";
      } else if (time.dateTime.hour == 4) {
        return "22";
      } else if (time.dateTime.hour == 5) {
        return "23";
      }
      else if (time.dateTime.hour > 15) {
        int hour = time.dateTime.hour -6;
        return hour.toString();
      } else {
        int hour2 = time.dateTime.hour -6;
        return "0" + hour2.toString();
      }
    }
    else {
      if (time.date.hour == 0){
        return "0" + time.date.hour.toString();
      } else if (time.date.hour == 1){
        return "19";
      } else if (time.date.hour == 2){
        return "20";
      } else if (time.date.hour == 3) {
        return "21";
      } else if (time.date.hour == 4) {
        return "22";
      } else if (time.date.hour == 5) {
        return "23";
      }
      else if (time.date.hour > 15) {
        int hour3 = time.date.hour - 6;
        return hour3.toString();
      } else {
        int hour4 = time.date.hour - 6;
        return "0" + hour4.toString();
      }
    }
  }

  static String getMinute(Event event, bool start) {
    EventDateTime time;
    if (start == true){
      time = event.start;
    }
    else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.minute > 9) {
        return time.dateTime.minute.toString();
      } else {
        return "0" + time.dateTime.minute.toString();
      }
    }
    else {
      if (time.date.minute > 9) {
        return time.date.minute.toString();
      } else {
        return "0" + time.date.minute.toString();
      }
    }
  }
  static String getSecond(Event event, bool start) {
    EventDateTime time;
    if (start == true){
      time = event.start;
    }
    else {
      time = event.end;
    }
    if (time.dateTime != null) {
      if (time.dateTime.second > 9) {
        return time.dateTime.second.toString();
      } else {
        return "0" + time.dateTime.second.toString();
      }
    }
    else {
      if (time.date.second > 9) {
        return time.date.second.toString();
      } else {
        return "0" + time.date.second.toString();
      }
    }
  }


  static String getDateFormat(Event event, bool start){
    return getYear(event, start) + "-" + getMonth(event, start) + "-" + getDay(event, start) + " " + getHour(event,start) + ":" + getMinute(event, start) + ":" + getSecond(event, start);
  }


  static List<Map<String,String>> getEventList() {
    bool duplicate = false;
    List<Map<String, String>> listOfEvents = [];
    List<Event> originalEvents = EventApi.getAllEvents();
    for (int i = 0; i < originalEvents.length; i++) {
      for (int z = 0; z < listOfEvents.length; z++){
        if (listOfEvents[z]['name'] == originalEvents[i].summary && listOfEvents[z]['date'] == getDateFormat(originalEvents[i], true)){
          duplicate = true;

        }
      }
     if (duplicate == false) {
       listOfEvents.add({
         'name'
             : originalEvents[i].summary,
         'location': originalEvents[i].location,
         'date': getDateFormat(originalEvents[i], true),
         'description': originalEvents[i].description,
         'end': getDateFormat(originalEvents[i], false)});
     }
      duplicate = false;
      }

    return listOfEvents;

  }







  @override
  Widget build(BuildContext context) {
    List<Map<String,String>> eventList = getEventList();


//    void onEventTapped(Map<String, String> event) {
//      print(event);
//    }

    eventsController.add(eventList);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      

      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            // default String parameter values used below as example
            new CalendarView(
              //onEventTapped: onEventTapped,
              titleField: 'name',
              detailField: 'location',
              dateField: 'date',
              endTime: 'end',
              desField: 'description',
              separatorTitle: 'Events',
              //theme: theme,
              eventStream: eventsController.stream,
            ),
          ],
        ),
      ),
    );
  }
}
