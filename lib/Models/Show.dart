import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './StatusEnum.dart';

const String defaultImage = "Hello";

class Show{
  int epsCompleted;
  String title;
  int epsTotal;
  ShowStatus status;
  String imageURL;

  Show({
    required this.title,
    required this.epsCompleted,
    required this.epsTotal,
    this.status = ShowStatus.planned,
    this.imageURL = defaultImage
  }){
    if(epsCompleted == epsTotal){
      status = ShowStatus.completed;
    }
    else if(epsCompleted > 0){
      status = ShowStatus.watching;
    }
    else{
      status = ShowStatus.planned;
    }
  }

  int getEpsCompleted(){
    return epsCompleted;
  }

  void incrementEps(){
    if(epsCompleted < epsTotal){
      epsCompleted++;
    }
  }
}

displayStatus(ShowStatus status){
  switch(status){
    case ShowStatus.watching:
      return ["Watching", Icon(CupertinoIcons.clock, size: 20, color: Colors.redAccent,),];
    case ShowStatus.onHold:
      return ["On Hold", Icon(Icons.pause, size: 20, color: Colors.redAccent,)];
    case ShowStatus.planned:
      return ["Planned", Icon(CupertinoIcons.cart, size: 20, color: Colors.redAccent,)];
    case ShowStatus.dropped:
      return ["Dropped", Icon(Icons.cancel, size: 20, color: Colors.redAccent,)];
    case ShowStatus.completed:
      return ["Completed", Icon(Icons.check, size: 20, color: Colors.redAccent,)];
  }
}