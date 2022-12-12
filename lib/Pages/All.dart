import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lister/Widgets/ShowTile.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Data/data.dart';
import '../Models/Show.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);
  
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
      return Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
          
              onReorder: (int oldIndex, int newIndex) { 
          
                if(newIndex > oldIndex) newIndex--;
          
                setState(() {
                  var show = shows.removeAt(oldIndex);
                  shows.insert(newIndex, show);
                });
          
                Provider.of<Data>(context, listen: false).allShows = shows;
                Provider.of<Data>(context, listen: false).distribute();
                Provider.of<Data>(context, listen: false).saveAllShows();
              },
          
              itemCount: shows.length,
              itemBuilder: (context, index) {
                return ShowTile(
                  key: ValueKey(index),
                  show: shows[index],
                );
              },
            ),
          )
        ],
      );
    }
  }
}