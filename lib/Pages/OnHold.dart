import 'package:flutter/material.dart';

import '../Data/data.dart';
import '../Models/Show.dart';


class OnHold extends StatefulWidget {
  const OnHold({Key? key}) : super(key: key);

  @override
  State<OnHold> createState() => _OnHoldState();
}

class _OnHoldState extends State<OnHold> {
  @override
  Widget build(BuildContext context) {

    var shows;
    if(onHoldShows.isEmpty){
      shows = <Show>[];
    } else {
      shows = onHoldShows;
    }

    @override
    void initState() {
      super.initState();
      distribute();
      shows = onHoldShows;
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
      return Text("On-hold");
    }
  }
}
