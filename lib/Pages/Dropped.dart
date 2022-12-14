import 'package:flutter/material.dart';
import 'package:lister/Data/data.dart';
import 'package:provider/provider.dart';

import '../Models/Show.dart';
import '../Widgets/ShowTile.dart';

class Dropped extends StatefulWidget {
  const Dropped({Key? key}) : super(key: key);

  @override
  State<Dropped> createState() => _DroppedState();
}

class _DroppedState extends State<Dropped> {
  @override
  Widget build(BuildContext context) {

    List<Show> shows;

    if(Provider.of<Data>(context).droppedShows.isEmpty){
      shows = <Show>[];
    } else {
      shows = Provider.of<Data>(context).droppedShows;
    }

    if(shows.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "No shows dropped",
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