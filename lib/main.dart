import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lister/Data/data.dart';
import 'package:lister/Pages/All.dart';

import 'Pages/Completed.dart';
import 'Pages/Dropped.dart';
import 'Pages/OnHold.dart';
import 'Pages/Planned.dart';
import 'Pages/Watching.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Lister'),
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

  final List<Widget> _pages = [
    All(show: allShows[0]),
    const Watching(),
    const OnHold(),
    const Planned(),
    const Dropped(),
    const Completed()
  ];

  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  selectDrawerItem(BuildContext context, int i) {
    setState(() {
      _currentPage = i;
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

  @override
  void initState() {
    super.initState();
    distribute();
  }

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

        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[850],

        leading: Builder(
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
        ),
      ),

      drawer: Drawer(
        child: ListView(
          // padding: notchInset,
          children: [
            ListTile(
              leading: Icon(Icons.list),
              title: Text('All'),
              onTap: () => selectDrawerItem(context, 0),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.clock),
              title: Text('Watching'),
              onTap: () => selectDrawerItem(context, 1),
            ),
            ListTile(
              leading: Icon(Icons.stop),
              title: Text('On-hold'),
              onTap: () => selectDrawerItem(context, 2),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.cart),
              title: Text('Planned'),
              onTap: () => selectDrawerItem(context, 3),
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Dropped'),
              onTap: () => selectDrawerItem(context, 4),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Completed'),
              onTap: () => selectDrawerItem(context, 5),
            ),
          ],
        ),
      ),
			
			body: Center(
				child: _pages[_currentPage],
			),
		);
  }    
}