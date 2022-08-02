import 'package:flutter/material.dart';
import 'package:lister/Data/data.dart';
import 'package:lister/Widgets/ShowTile.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Models/Show.dart';

class All extends StatelessWidget {
  const All({Key? key, required this.shows}) : super(key: key);
  
  final List<Show> shows;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shows.length,
      itemBuilder: (context, index) {
        return ShowTile(show: shows[index]);
      },
    );
  }
}