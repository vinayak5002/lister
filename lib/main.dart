import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[850],

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.redAccent,
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
          children: const [
            ListTile(
              leading: Icon(Icons.list),
              title: Text('All'),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.clock),
              title: Text('Watching'),
            ),
            ListTile(
              leading: Icon(Icons.stop),
              title: Text('On-hold'),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.cart),
              title: Text('Planned'),
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Dropped'),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Completed'),
            ),
          ],
        ),
      ),
			
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						const Text(
							'You have pushed the button this many times:',
						),
						Text(
							'$_counter',
							style: Theme.of(context).textTheme.headline4,
						),
					],
				),
			),
		);
  }
}
