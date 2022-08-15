import 'package:lister/Models/Show.dart';
import 'package:lister/Models/StatusEnum.dart';
import '../Models/Show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Data extends ChangeNotifier{

  var allShows = [
    Show(malId: 20, title: "Naruto", epsCompleted: 190, epsTotal: 220, status: ShowStatus.completed, imageURL: "https://cdn.myanimelist.net/images/anime/13/17405l.jpg"),
    Show(malId: 50380, title: "Paripi Koumei", epsCompleted: 8, epsTotal: 12, status: ShowStatus.watching, imageURL: "https://cdn.myanimelist.net/images/anime/1970/122297l.jpg"),
    // Show(malId: 44511, title: "Chainsaw Man", epsCompleted: 0, epsTotal: 24, status: ShowStatus.planned, imageURL: "https://cdn.myanimelist.net/images/anime/1806/126216l.jpg"),
  ];

  List<Show> watchingShows = [];
  List<Show> onHoldShows = [];
  List<Show> plannedShows = [];
  List<Show> droppedShows = [];
  List<Show> completedShows = [];

  void distribute(){
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

  int getCount(int index){
    switch(index){
      case 0:
        return allShows.length;
      case 1:
        return watchingShows.length;
      case 2:
        return onHoldShows.length;
      case 3:
        return plannedShows.length;
      case 4:
        return droppedShows.length;
      case 5:
        return completedShows.length;
    }
    return 0;
  }

  void increaseEps(Show show){
    for(Show sh in allShows){
      if(sh == show){
        if(show.status == ShowStatus.planned){
          sh.status = ShowStatus.watching;
        }

        if(show.status == ShowStatus.onHold){
          sh.status = ShowStatus.watching;
        }

        sh.epsCompleted++;

        if(show.epsTotal == show.epsCompleted){
          sh.status = ShowStatus.completed;
        }

        distribute();
        return;
      }
    }
  }

  void setStatus(Show show, ShowStatus status){
    for(Show sh in allShows){
      if(sh == show){
        if(show.status != ShowStatus.completed){
          sh.status = status;
          distribute();
        }
        return;
      }
    }
  }

  displayStatus(ShowStatus status){
    switch(status){
      case ShowStatus.watching:
        return ["Watching", const Icon(CupertinoIcons.clock, size: 20, color: Colors.redAccent,),];
      case ShowStatus.onHold:
        return ["On Hold", const Icon(Icons.pause, size: 20, color: Colors.redAccent,)];
      case ShowStatus.planned:
        return ["Planned", const Icon(CupertinoIcons.cart, size: 20, color: Colors.redAccent,)];
      case ShowStatus.dropped:
        return ["Dropped", const Icon(Icons.cancel, size: 20, color: Colors.redAccent,)];
      case ShowStatus.completed:
        return ["Completed", const Icon(Icons.check, size: 20, color: Colors.redAccent,)];
    }
  }

  void addShow(Show show){
    bool exists = false;

    for(Show sh in allShows){
      if(sh.malId == show.malId){
        exists = true;
        break;
      }
    }

    if(!exists){
      allShows.insert(0, show);
      distribute();
      notifyListeners();
    }
  }

}