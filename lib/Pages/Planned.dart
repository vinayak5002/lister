import 'package:flutter/material.dart';

import '../Data/data.dart';
import '../Models/Show.dart';
import '../Widgets/ShowTile.dart';


class Planned extends StatefulWidget {
  const Planned({Key? key}) : super(key: key);

  @override
  State<Planned> createState() => _PlannedState();
}

class _PlannedState extends State<Planned> {
  @override
  Widget build(BuildContext context) {


    var shows;
    if(plannedShows.length ==0){
      shows = <Show>[];
    } else {
      shows = plannedShows;
    }

    initState() {
      super.initState();
      shows = plannedShows;
    }

    if(shows.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "No shows planned",
              style: TextStyle(
                color: Colors.grey,
              )
            ),
            Image.asset(
              "assets/images/done.png",
              height: 200,
            ),
          ],
        ),
      );
    }
    else{
      return ListView.builder(
        itemCount: shows.length,
        itemBuilder: (context, index) {
          return ShowTile(
            show: shows[index],
          );
        },
      );
    }
  }
}