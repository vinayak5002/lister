import 'package:lister/Models/Show.dart';
import 'package:lister/Models/StatusEnum.dart';
import '../Models/Show.dart';

var allShows = [
  Show(title: "Naruto", epsCompleted: 190, epsTotal: 220, status: ShowStatus.completed),
  Show(title: "Ya Boy Koming!", epsCompleted: 8, epsTotal: 12, status: ShowStatus.watching),
  Show(title: "Chainsaw Man", epsCompleted: 0, epsTotal: 24, status: ShowStatus.planned),
];

var watchingShows = [];
var onHoldShows = [];
var plannedShows = [];
var droppedShows = [];
var completedShows = [];

void distribute(){
  for(int i=0; i<allShows.length; i++){
    switch(allShows[i].status){
      case ShowStatus.watching:
        watchingShows.add(allShows[i]);
        break;
      case ShowStatus.onHold:
        onHoldShows.add(allShows[i]);
        break;
      case ShowStatus.planned:
        plannedShows.add(allShows[i]);
        break;
      case ShowStatus.dropped:
        droppedShows.add(allShows[i]);
        break;
      case ShowStatus.completed:
        completedShows.add(allShows[i]);
        break;
    }
  }
}