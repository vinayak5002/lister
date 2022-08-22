import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/data.dart';
import '../Models/Show.dart';
import '../Widgets/ShowTile.dart';


class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {

    List<Show> shows;
    if(Provider.of<Data>(context).completedShows.isEmpty){
      shows = <Show>[];
    } else {
      shows = Provider.of<Data>(context).completedShows;
    }

    if(shows.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "No shows",
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