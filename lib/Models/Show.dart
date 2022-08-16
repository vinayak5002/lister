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

  static fromMap(Map<String, dynamic> jsonData) {
    return Show(
      malId: jsonData['malId'],
      title: jsonData['title'],
      epsCompleted: jsonData['epsCompleted'],
      epsTotal: jsonData['epsTotal'],
      status: ShowStatus.values[jsonData['status']],
      imageURL: jsonData['imageURL'] ?? defaultImage,
      airStatus: AirStatus.values[jsonData['airStatus']]
    );
  }

  static Map<String, dynamic> toMap(Show show) => {
    'malId': show.malId,
    'title': show.title,
    'epsCompleted': show.epsCompleted,
    'epsTotal': show.epsTotal,
    'status': show.status.index,
    'imageURL': show.imageURL,
    'airStatus': show.airStatus.index
  };
}