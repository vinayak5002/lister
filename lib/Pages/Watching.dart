import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/data.dart';
import '../Models/Show.dart';
import '../Widgets/ShowTile.dart';

class Watching extends StatefulWidget {
  const Watching({Key? key}) : super(key: key);

  @override
  State<Watching> createState() => _WatchingState();
}

class _WatchingState extends State<Watching> {
  @override
  Widget build(BuildContext context) {

    List<Show> shows;
    if(Provider.of<Data>(context).watchingShows.isEmpty){
      shows = <Show>[];
    } else {
      shows = Provider.of<Data>(context).watchingShows;
    }

    return ListView.builder(
      itemCount: shows.length,
      itemBuilder: (context, index) {
        return ShowTile(show: shows[index]);
      },
    );
  }
}
