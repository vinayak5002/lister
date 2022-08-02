import 'package:lister/Models/Show.dart';
import 'package:lister/Models/StatusEnum.dart';
import '../Models/Show.dart';

var allShows = [
  Show(title: "Naruto", epsCompleted: 190, epsTotal: 220, status: ShowStatus.completed),
  Show(title: "Ya Boy Koming!", epsCompleted: 8, epsTotal: 12, status: ShowStatus.watching),
  Show(title: "Chainsaw Man", epsCompleted: 0, epsTotal: 24, status: ShowStatus.planned),
];

List<Show> watchingShows = [];
List<Show> onHoldShows = [];
List<Show> plannedShows = [];
List<Show> droppedShows = [];
List<Show> completedShows = [];

void distribute(){
  print("Distributing...");
  watchingShows.clear();
  onHoldShows.clear();
  plannedShows.clear();
  droppedShows.clear();
  completedShows.clear();

  for(Show show in allShows){
    switch(show.status){
      case ShowStatus.watching:
        watchingShows.add(show);
        break;
      case ShowStatus.onHold:
        onHoldShows.add(show);
        break;
      case ShowStatus.planned:
        plannedShows.add(show);
        break;
      case ShowStatus.dropped:
        droppedShows.add(show);
        break;
      case ShowStatus.completed:
        completedShows.add(show);
        break;
    }
  }
}