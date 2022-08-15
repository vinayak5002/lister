import 'package:flutter/material.dart';
import 'package:lister/Widgets/ShowTile.dart';
import 'package:provider/provider.dart';

import '../Data/data.dart';
import '../Models/Show.dart';

class All extends StatefulWidget {
  All({Key? key}) : super(key: key);
  
  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {

    List<Show> shows;
    if(Provider.of<Data>(context).allShows.isEmpty){
      shows = <Show>[];
    } else {
      shows = Provider.of<Data>(context).allShows;
    }
    @override
    void initState() {
      super.initState();
      Provider.of<Data>(context).distribute();
      shows = Provider.of<Data>(context).allShows;
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