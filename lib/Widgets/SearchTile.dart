import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lister/Models/StatusEnum.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Data/data.dart';
import '../Models/Show.dart';

class SearchShowTile extends StatefulWidget {
  SearchShowTile({Key? key, required this.show}) : super(key: key);

  final Show show;

  @override
  State<SearchShowTile> createState() => _SearchShowTileState();
}

class _SearchShowTileState extends State<SearchShowTile> {

  @override
  Widget build(BuildContext context) {
    late final status = displayStatus(widget.show.status);

    
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),

      child: Card(
        color: const Color.fromRGBO(33, 33, 33, 1),
        
        child: Padding(
          padding: const EdgeInsets.all(4.0),

          child: Row(
            children: [
              Image.network(widget.show.imageURL, height: 100, width: 100,),

              Expanded(
                child: SizedBox(
                  width: 10000,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.show.title.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                maxLines: 10,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
              
                        const SizedBox(height: 5,),
              
                        Text(
                          "Episodes : ${widget.show.epsTotal == 0 ? "N/A" : widget.show.epsTotal}",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
              
                        const SizedBox(height: 5,),

                        Text(
                          widget.show.epsTotal == 1? "Movie" : "Series",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
              
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        )
      )
    );
  }
}