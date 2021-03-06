//MIT License
//Copyright (c) 2018 Taylor Smith

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';
import 'package:mac_mobile_attempt/helpers/custom_expansion_tile.dart' as custom;


/*
This file creates the design of the widgets that display the events on the
events Tab.
 */

class EventsView extends StatelessWidget {
  const EventsView(
      {Key key,
      this.events,
      this.month,
      this.currentDay,
      this.onEventTapped,
      this.titleField,
      this.desField,
      this.endTime,
      this.detailField,
      this.dateField,
      this.theme})
      : super(key: key);

  final Map<int, List> events;
  final int month;
  final int currentDay;
  final Function onEventTapped;
  final String titleField;
  final String desField;
  final String endTime;
  final String detailField;
  final String dateField;
  final ThemeData theme;
 
  String getDescription(Map<String, String> event) {
    //Returns the proper event description.
    if (event['description'] != null) {
      event['description'] = event['description'].replaceAll('&quot;', " ");
      event['description'] = event['description']
          .replaceAll('&nbsp;', " "); 
      event['description'] = event['description']
          .split("Sponsored by ")[0];  
      if(event['description'] == " "){
        return "No description.               ";
      }
      return event[desField];
    }
    else {
      return "No description.               ";
    }
  }

  String getLocations(Map<String, String> event) {
    //Returns the proper event location.
    if (event['location'] != null) {
      return event[detailField];
    } else {
      return "Macalester College";
    }
  }

  String getName(Map<String, String> event) {
    //Returns the name of the event.
    if (event['name'] != null) {
      return event['name'];
    } else {
      return "Untitled Event";
    }
  }


  String formatTime(event) {
    //Formats the event time properly to display on the calendar.
    //For example, it formats an event from 1:00 AM - 3:00 AM as 1:00-3:00
    if (DateFormat.Hm().format(DateTime.parse(event['date'])) == "00:00") {
      return "All Day   ";
    } else {
      if (event['name'].contains("Popular")) {
      }
      return DateFormat.Hm().format(DateTime.parse(event['date'])) +
          "-" +
          DateFormat.Hm().format(DateTime.parse(event['end'])) +
          "   ";
    }
  }

  String getMonthName(int month) {
    if (month == 1) {
      return "January";
    } else if (month == 2) {
      return "February";
    } else if (month == 3) {
      return "March";
    } else if (month == 4) {
      return "April";
    } else if (month == 5) {
      return "May";
    } else if (month == 6) {
      return "June";
    } else if (month == 7) {
      return "July";
    } else if (month == 8) {
      return "August";
    } else if (month == 9) {
      return "September";
    } else if (month == 10) {
      return "October";
    } else if (month == 11) {
      return "November";
    } else {
      return "December";
    }
  }

  Widget eventRow(int day, Map<String, String> event) {
    //Creates the boxes that hold the calendar event information
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0XFF01426A),
          border: Border.all(
            color: prefix0.Colors.white,
          ),
        ),
        child: Column(
          children: <Widget>[
            Card(
                elevation: 6,
                clipBehavior: Clip.hardEdge,
                color: Color(0XFF01426A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "   " + getMonthName(month) + " " + day.toString(),
                          style: TextStyle(
                            color: prefix0.Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          formatTime(event),
                          style: TextStyle(
                            color: prefix0.Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(4), // text padding
                    ),
                    custom.ExpansionTile(
                      iconColor: Color(0XFF01426A),
                      backgroundColor: prefix0.Colors.white,
                      headerBackgroundColor: prefix0.Colors.white,
                      initiallyExpanded: false,
                      title: Column(
                        children: <Widget>[
                          _singleBlock(day, event),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(28, 0, 20, 10),
                          child: Text(
                            getDescription(event),
                            style: TextStyle(color: prefix0.Colors.grey[800]),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _singleBlock(int day, Map<String, String> event) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(7), // text padding
          ),
          Container(
            color: prefix0.Colors.white,
            padding: const EdgeInsets.only(bottom: 15), //text space
            child: Text(
              //"Event",
              getName(event),
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                  color: prefix0.Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.place,
                size: 16,
                color: Color(0xFF5B6770),
              ),
              Flexible(
                child: Text(
                  "  " + getLocations(event),
                  style: TextStyle(fontSize: 14, color: prefix0.Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 15.0)),
        ]);
  }

  List<Widget> eventList() {
    List<Widget> list = [];
    events.forEach((int day, List dayEvents) {
      if (currentDay == 0 || currentDay == day) {
        for (var i = 0; i < dayEvents.length; i++) {
          list.add(eventRow(day, dayEvents[i]));
          list.add(Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          ));
        }
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    //Builds each event widget.
    return Expanded(
      child: Container(
        color: prefix0.Colors.grey[100],
        padding: EdgeInsets.all(5),
        child: ListView(
          children: eventList(),
        ),
      ),
    );
  }
}
