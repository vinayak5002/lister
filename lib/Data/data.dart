import 'dart:convert';

import 'package:lister/Models/Show.dart';
import 'package:lister/Models/StatusEnum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as API ;
import 'package:lister/Data/constanst.dart';

class Data extends ChangeNotifier{

  var allShows = [
    Show(
      malId: 20,
      title: "Naruto",
      epsCompleted: 190,
      epsTotal: 220,
      status: ShowStatus.completed,
      imageURL: "https://cdn.myanimelist.net/images/anime/13/17405l.jpg",
      airStatus: AirStatus.finished,
      gogoName: '',
      updating: false
    ),
  ];

  List<Show> watchingShows = [];
  List<Show> onHoldShows = [];
  List<Show> plannedShows = [];
  List<Show> droppedShows = [];
  List<Show> completedShows = [];

  bool updatingAiringShows = false;
  int updatingIndex = 0;

  Data() {
    allShows.clear();
    loadAllShows();
  }

  void loadAllShows() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String>? loadedData = pref.getStringList("allShows");

    if (loadedData != null) {
      allShows = loadedData.map<Show>((show) => Show.fromMap(jsonDecode(show))).toList();
    }
    else {
      allShows = [];
    }

    distribute();

    notifyListeners();

    updateAiringShows();
  }

  void updateAiringShows() async{
    updatingAiringShows = true;
    updatingIndex = 0;
    notifyListeners();

    for(Show show in allShows){
      updatingIndex++;
      notifyListeners();

      if(show.gogoName == ""){
        continue;
      }

      if(show.airStatus != AirStatus.finished ){

        API.Response showstatus = await API.get(
          Uri.parse("https://lister-api.onrender.com/${show.gogoName}")
        );

        var jsonResponse = showstatus.body;

        var data = jsonDecode(jsonResponse);

        if(data['error'] != true){
          
          AirStatus newAiringStatus = AirStatus.shedueled;
          switch(data['status']){
            case 'Ongoing':
              newAiringStatus = AirStatus.airing;
              break;
            
            case 'Upcomming':
              newAiringStatus = AirStatus.shedueled;
              break;
            
            case 'Completed':
              newAiringStatus = AirStatus.finished;
              break;
          }

          show.airStatus = newAiringStatus;
          show.epsTotal = data['epstotal'];
        }
      }
    }

    updatingAiringShows = false;

    distribute();

    notifyListeners();

    saveAllShows();
  }

  void saveAllShows() async{
    List<String> saveList = allShows.map((e) => jsonEncode(Show.toMap(e))).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList("allShows", saveList);
  }

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
    notifyListeners();
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
          if(show.airStatus != AirStatus.airing){
            sh.status = ShowStatus.completed;
          }
        }

        distribute();
        notifyListeners();
        saveAllShows();
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
          notifyListeners();
          saveAllShows();
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

  Future<void> addShow(Show show) async {
    bool exists = false;

    for(Show sh in allShows){
      if(sh.malId == show.malId){
        exists = true;
        break;
      }
    }

    if(!exists){
      API.Response searchRes = await API.get(
        Uri.parse(kSearch2BaseURL + show.title)
      );
  
      String jsonResponse;

      if(searchRes.statusCode == 200){
        jsonResponse = searchRes.body;

        var data = jsonDecode(jsonResponse);

        show.gogoName = data[0]['animeId'];
        saveAllShows();

      }

      show.status = ShowStatus.planned;
      allShows.insert(0, show);
      distribute();
      notifyListeners();
      saveAllShows();
      updateAiringShows();
    }
  }

  void updateEps(Show show, int newValue){
    for(Show sh in allShows){
      if(sh == show){

        if(show.status == ShowStatus.planned){
          sh.status = ShowStatus.watching;
        }

        if(show.status == ShowStatus.onHold){
          sh.status = ShowStatus.watching;
        }

        sh.epsCompleted = newValue;

        if(show.epsTotal == show.epsCompleted){
          if(show.airStatus != AirStatus.airing){
            sh.status = ShowStatus.completed;
          }
        }

        distribute();
        notifyListeners();
        saveAllShows();
        return;
      }
    }
  }

  void deleteShow(Show show) {
    for(Show sh in allShows){
      if(sh == show){
        allShows.remove(sh);
        distribute();
        notifyListeners();
        saveAllShows();
        return;
      }
    }
  }
}