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