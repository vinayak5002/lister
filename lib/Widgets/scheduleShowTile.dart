import 'package:flutter/material.dart';

import '../Models/Show.dart';


class ScheduleShowTile extends StatelessWidget {
  final Show show;

  const ScheduleShowTile({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(show.imageURL, height: 100, width: 100),
        ],
      ),
    );
  }
}
