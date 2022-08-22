import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:lister/Widgets/SearchTile.dart';
import 'package:http/http.dart' as API ;
import 'package:lister/Data/constanst.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Models/Show.dart';
import '../Models/StatusEnum.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController name = TextEditingController();

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Page(name: name),
    );
  }
}

class Page extends StatefulWidget {
  const Page({
    Key? key,
    required this.name,
  }) : super(key: key);

  final TextEditingController name;

  @override
  State<Page> createState() => _PageState();
}

List<Show> searchShows = [];

class _PageState extends State<Page> {

  bool isLoading = false;

  search(String query)async{
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

        if(i['airing'] == false){
          if(i['episodes'] == null){
            thisAirStatus = AirStatus.shedueled;
          }
          else{
            thisAirStatus = AirStatus.finished;
          }
        }
        else{
          thisAirStatus = AirStatus.airing;
        }

        searchShows.add(Show(
          malId: i['mal_id'],
          title: i['title'],
          epsCompleted: 0,
          epsTotal: i['episodes'] ?? 0,
          status: ShowStatus.planned,
          imageURL: i['images']['jpg']['large_image_url'],
          airStatus: thisAirStatus
        ));
        setState(() {});
      }

    }
    else{
      searchShows.clear();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Show'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[850],  
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.name,
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
                        search(widget.name.text);
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
      )
    );
  }
}