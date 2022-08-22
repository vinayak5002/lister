import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/data.dart';
import '../Models/Show.dart';
import '../Widgets/ShowTile.dart';


class OnHold extends StatefulWidget {
  const OnHold({Key? key}) : super(key: key);

  @override
  State<OnHold> createState() => _OnHoldState();
}

class _OnHoldState extends State<OnHold> {
  @override
  Widget build(BuildContext context) {

    List<Show> shows;
    if(Provider.of<Data>(context).onHoldShows.isEmpty){
      shows = <Show>[];
    } else {
      shows = Provider.of<Data>(context).onHoldShows;
    }

    if(shows.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "No shows on hold",
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
