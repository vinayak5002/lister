import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:lister/Widgets/SearchTile.dart';
import 'package:http/http.dart' as API ;
import 'package:lister/Data/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Models/Show.dart';
import '../Models/StatusEnum.dart';


class AddPage extends StatefulWidget {
  const AddPage({Key? key,}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

List<Show> searchShows = [];

class _AddPageState extends State<AddPage> {

  TextEditingController name = TextEditingController();

  bool isLoading = false;
  bool _connection = false;

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _connection = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _connection = false;
      });
    }
    return false;
  }
  
  search(String query)async{
    if(_connection){
      setState(() {
        isLoading = true;
      });

      API.Response response = await API.get( Uri.parse(kSearchBaseURL + query + kSearchEndURL) );
      searchShows.clear();

      setState(() {
        isLoading = false;
      });

      String jsonResponse;

      if(response.statusCode == 200){
        jsonResponse = response.body;

        var data = jsonDecode(jsonResponse)['data'];

        for(var i in data){

          AirStatus thisAirStatus;
          int thisAirWeekDay = 0;

          if(i['airing'] == false){
            if(i['status'] == "Not yet aired"){
              thisAirStatus = AirStatus.shedueled;
            }
            else{
              thisAirStatus = AirStatus.finished;
            }
          }
          else{
            thisAirStatus = AirStatus.airing;
          }

          if(thisAirStatus == AirStatus.airing){
            switch (i['broadcast']['day']) {
              case "Mondays":
                thisAirWeekDay = 1;
                break;
              case "Tuesdays":
                thisAirWeekDay = 2;
                break;
              case "Wednesdays":
                thisAirWeekDay = 3;
                break;
              case "Thursdays":
                thisAirWeekDay = 4;
                break;
              case "Fridays":
                thisAirWeekDay = 5;
                break;
              case "Saturdays":
                thisAirWeekDay = 6;
                break;
              case "Sundays":
                thisAirWeekDay = 7;
                break;
              default:
                thisAirWeekDay = 0;
            }
          }

          searchShows.add(Show(
            malId: i['mal_id'],
            title: i['title'],
            epsCompleted: 0,
            epsTotal: i['episodes'] ?? 0,
            status: ShowStatus.planned,
            imageURL: i['images']['jpg']['large_image_url'],
            airStatus: thisAirStatus,
            gogoName: " ",
            airWeekDay: thisAirWeekDay,
            lastUpdated: DateTime.now()
          ));
          setState(() {});
        }

      }
      else{
        searchShows.clear();
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    checkConnection();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      fillColor: Colors.red,
                      border: OutlineInputBorder(),
                      hintText: "Enter show name"
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: InkWell(
                    onTap: (){
                      search(name.text);
                    },
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Icons.search, color: Colors.white,),
                    ),
                  ),
                )
              ],
            ),
          ),

          !_connection ?
          Image.asset("assets/images/noInternet.png", height: 100,):

          isLoading ? 
          const SpinKitWave(color: Colors.redAccent,)
          : 

          Expanded(
            child: ListView.builder(
              itemCount: searchShows.length,
              itemBuilder: (context, index){
                return SearchShowTile(show: searchShows[index]);
              },
            ),
          )
        ],
      ),

    );
  }
}