import 'package:flutter/material.dart';

import '../Data/data.dart';
import '../Models/Show.dart';
import '../Widgets/ShowTile.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    TextEditingController name = TextEditingController();

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add Show'),
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
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: (){
                          print(name.text);
                        },
                        child: Icon(Icons.search, color: Colors.white,)
                      ),
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: allShows.length,
                itemBuilder: (context, index){
                  return ShowTile(show: allShows[index]);
                },
              ),
            )
          ],
        )
      ),
    );
  }
}