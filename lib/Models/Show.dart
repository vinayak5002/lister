import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './StatusEnum.dart';

const String defaultImage = "Hello";

class Show{
  int malId;
  int epsCompleted;
  String title;
  int epsTotal;
  ShowStatus status;
  String imageURL;
  AirStatus airStatus;

  Show({
    required this.malId,
    required this.title,
    required this.epsCompleted,
    required this.epsTotal,
    this.status = ShowStatus.planned,
    required this.imageURL,
    required this.airStatus
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