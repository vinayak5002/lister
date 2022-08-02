import 'package:flutter/material.dart';
import 'package:lister/Data/data.dart';
import 'package:lister/Widgets/ShowTile.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Models/Show.dart';

class All extends StatelessWidget {
  const All({Key? key, required this.show}) : super(key: key);
  
  final Show show;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowTile(show: show,)
      ],
    );
  }
}