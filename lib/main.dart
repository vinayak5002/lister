import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lister/Data/data.dart';
import 'package:lister/Pages/All.dart';
import 'package:provider/provider.dart';

import 'Pages/AddPage.dart';
import 'Pages/Completed.dart';
import 'Pages/Dropped.dart';
import 'Pages/OnHold.dart';
import 'Pages/Planned.dart';
import 'Pages/Watching.dart';
import 'Data/data.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Data(),
        ),
      ],
      child: MaterialApp(
        title: 'Lister',
        theme: ThemeData.dark(),
        home: const MyHomePage(title: 'Lister'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentPage = 0;
  int _selectedIndex = 0;

  void _onItemTapped(int newIndex){
    setState(() {
      _selectedIndex = newIndex;
    });

    if(newIndex == 1){
      setState(() {
        bodyContent = const AddPage();
      });
    }
    if(newIndex == 0){
      bodyContent = Center(
        child: _pages[_currentPage],
      );
    }
  } 

  final List<Widget> _pages = [
    const All(),
    const Watching(),
    const OnHold(),
    const Planned(),
    const Dropped(),
    const Completed()
  ];

  var bodyContent;

  selectDrawerItem(BuildContext context, int i) {
    setState(() {
      Provider.of<Data>(context, listen: false).distribute();
      bodyContent = Center(
        child: _pages[i],
      );
    });

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    bodyContent = Center(
      child: _pages[_currentPage],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
			appBar: AppBar(
				title: Text(
          widget.title,
          textScaleFactor: 1.5,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
          
        ),

        actions: _selectedIndex == 0 ?
        [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              Provider.of<Data>(context).getCount(_currentPage).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                fontSize: 18,
              ),
            ),
          ),
        ] : [],

        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[850],

        leading: _selectedIndex == 0 ?
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.redAccent,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ) : Container(),
      ),

      drawer: _selectedIndex == 0 ?
      Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('All'),
              onTap: () => selectDrawerItem(context, 0),
              trailing: Text(Provider.of<Data>(context).allShows.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.clock),
              title: const Text('Watching'),
              onTap: () => selectDrawerItem(context, 1),
              trailing: Text(Provider.of<Data>(context).watchingShows.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.pause),
              title: const Text('On-hold'),
              onTap: () => selectDrawerItem(context, 2),
              trailing: Text(Provider.of<Data>(context).onHoldShows.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.cart),
              title: const Text('Planned'),
              onTap: () => selectDrawerItem(context, 3),
              trailing: Text(Provider.of<Data>(context).plannedShows.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Dropped'),
              onTap: () => selectDrawerItem(context, 4),
              trailing: Text(Provider.of<Data>(context).droppedShows.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Completed'),
              onTap: () => selectDrawerItem(context, 5),
              trailing: Text(Provider.of<Data>(context).completedShows.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ) : Container(),
			
			body: bodyContent,

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "List"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "New"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Shedule"
          )
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
		);
  }    
}