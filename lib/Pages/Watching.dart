import 'package:flutter/material.dart';

import '../Data/data.dart';
import '../Models/Show.dart';
import '../Widgets/ShowTile.dart';

class Watching extends StatefulWidget {
  Watching({Key? key}) : super(key: key);

  @override
  State<Watching> createState() => _WatchingState();
}

class _WatchingState extends State<Watching> {
  @override
  Widget build(BuildContext context) {

    var shows;
    if(watchingShows.length == 0){
      shows = <Show>[];
    } else {
      shows = watchingShows;
    }
    initState(){
      super.initState();
      distribute();
      shows = watchingShows;
    }

    return ListView.builder(
      itemCount: shows.length,
      itemBuilder: (context, index) {
        return ShowTile(show: shows[index]);
      },
    );
  }
}
