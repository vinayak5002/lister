import 'dart:convert';

import './StatusEnum.dart';

class Show{
  int malId;
  int epsCompleted;
  String title;
  int epsTotal;
  ShowStatus status;
  String imageURL;
  AirStatus airStatus;
  String gogoName;
  late DateTime lastUpdated = DateTime.now();

  Show({
    required this.malId,
    required this.title,
    required this.epsCompleted,
    required this.epsTotal,
    required this.status,
    required this.imageURL,
    required this.airStatus,
    required this.gogoName,
    lastUpdated
  });

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
      imageURL: jsonData['imageURL'],
      airStatus: AirStatus.values[jsonData['airStatus']],
      gogoName: jsonData['gogoName'],
      lastUpdated: DateTime.parse(jsonData['lastUpdated'] ?? DateTime.now().toString())
    );
  }

  static Map<String, dynamic> toMap(Show show) {
    if(show.lastUpdated == Null){
      show.lastUpdated = DateTime(2003);
    }
    return {
    'malId': show.malId,
    'title': show.title,
    'epsCompleted': show.epsCompleted,
    'epsTotal': show.epsTotal,
    'status': show.status.index,
    'imageURL': show.imageURL,
    'airStatus': show.airStatus.index,
    'gogoName' : show.gogoName,
    'lastUpdated': show.lastUpdated.toString()
  };
  }
}