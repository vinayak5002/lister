import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lister/Data/data.dart';
import 'package:lister/Models/Show.dart';
import 'package:lister/Models/StatusEnum.dart';
import 'package:provider/provider.dart';

class ShedulePage extends StatefulWidget {
  const ShedulePage({Key? key}) : super(key: key);

  @override
  _ShedulePageState createState() => _ShedulePageState();
}

class _ShedulePageState extends State<ShedulePage> {

  Map<int, List<Show>> schedule = HashMap();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Show> shows = Provider.of<Data>(context).allShows;

    for(int i=1; i<=7; i++){
      schedule[i] = <Show>[];
    }

    for(Show show in shows){
      if( show.airStatus == AirStatus.airing){
        schedule[show.airingDay.weekday]?.add(show);
        print("Added show ${show.title}, ${show.airingDay.weekday}");
      }
    }
    return ListView(
      children: [
        WeekTile(weekday: "Sunday", dayShows: schedule[7]),
        WeekTile(weekday: "Monday", dayShows: schedule[1]),
        WeekTile(weekday: "Tuesday", dayShows: schedule[2],),
        WeekTile(weekday: "Wednesday", dayShows: schedule[3],),
        WeekTile(weekday: "Thursday", dayShows: schedule[4],),
        WeekTile(weekday: "Friday", dayShows: schedule[5],),
        WeekTile(weekday: "Saturday", dayShows: schedule[6],)
      ]
    );
  }
}

class WeekTile extends StatefulWidget {
  String weekday;

  List<Show>? dayShows;

  WeekTile({Key? key, required this.weekday, required this.dayShows}) : super(key: key);

  @override
  _WeekTileState createState() => _WeekTileState();
}

class _WeekTileState extends State<WeekTile> {
  @override
  Widget build(BuildContext context) {
    // print("shows lenght ${widget.dayShows![0].imageURL}");
    return Container(
      width: 100000,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        color: const Color.fromRGBO(33, 33, 33, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.weekday),
                  widget.dayShows!.isNotEmpty ? Text(widget.dayShows![0].title) : Text("Empty")
                ],
              )
          )
        )
      )
    );
  }
}

