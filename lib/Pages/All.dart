import 'package:flutter/material.dart';
import 'package:lister/Data/data.dart';

import '../Models/Show.dart';

class All extends StatelessWidget {
  const All({Key? key, required this.show}) : super(key: key);
  
  final Show show;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),

            child: Card(
              color: const Color.fromRGBO(33, 33, 33, 1),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(

                  title: Text(
                    show.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${show.epsCompleted}/${show.epsTotal}",
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      LinearProgressIndicator(
                        backgroundColor: Colors.green,
                        
                      )
                    ],
                  ),

                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.add, color: Colors.redAccent,),
                  )
                ),
              ),
            ),
            // child: ListTile(
            //   title: Column(
            //     children: [
            //       Text(show.title),
            //     ],
            //   ),
            //   subtitle: Column(
            //     children: [
            //       Text("${show.epsCompleted}/${show.epsTotal}"),
            //       Text("100%")
            //     ],
            //   ),

            //   trailing: Icon(Icons.add, color: Colors.redAccent),

            //   tileColor: const Color.fromRGBO(33, 33, 33, 1),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
          ),
        ],
      )
    );
  }
}