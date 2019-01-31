import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:swipedetector/swipedetector.dart';

import './presentation/my_flutter_app_icons.dart';

void main() {
//  debugPaintSizeEnabled=true;
  runApp(MyApp());
}

enum Action { INCREASE, DECREASE, TO_ZERO }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.deepOrange,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );

    return MaterialApp(
      title: 'Munchkin kill-o-meter',
      theme: new ThemeData(
        primaryColor: Colors.deepOrange[600],
        accentColor: Colors.deepOrangeAccent,
        highlightColor: Colors.deepOrangeAccent[200],
//        backgroundColor: Colors.deepOrangeAccent[100]
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => new MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  int total = 0;

  callback(Action action, [int decreaseValue]) {
    // TODO add some validation on optional parameters ?
    setState(() {
      switch (action) {
        case Action.INCREASE:
          total++;
          break;
        case Action.DECREASE:
          total--;
          break;
        case Action.TO_ZERO:
          total = total - decreaseValue;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
//    return Text('hello world1');
    return Ink(
      color: Colors.deepOrange[100],
      padding: EdgeInsets.all(20.0),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Card(
                  child: Padding(
            padding:
                const EdgeInsets.only(left: 50, top: 25, right: 50, bottom: 25),
            child: Text("$total"),
          ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//              RaisedButton(onPressed: () {},
//              color: Colors.deepOrange,),
              CounterCell(callback),
              CounterCell(callback),
              CounterCell(callback),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterCell(callback),
              CounterCell(callback),
              CounterCell(callback),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//              CounterCell(callback),
              CounterCell(callback),
              FloatingActionButton(
                onPressed: () {
                  print("pressed");
                },
                child: Icon(MyFlutterApp.skull_n_bones),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CounterCell extends StatefulWidget {
  Function(Action, [int]) callback;
//  final snackBar = SnackBar(content: Text('Yay! A SnackBar!')); //Scaffold.of(context).showSnackBar(snackBar);

  CounterCell(this.callback);

  @override
  State<StatefulWidget> createState() => new CounterCellState();
}

class CounterCellState extends State<CounterCell> {
  int _point = 0;
  void _handleTap() {
    setState(() {
      widget.callback(Action.INCREASE); //call to parent
      print('tap');
      _point++;
    });
  }

  void _handleDoubleTap() {
    setState(() {
      widget.callback(Action.DECREASE);
      print('dtap');
      _point--;
    });
  }

  void _handleLongTap() {
    setState(() {
      widget.callback(Action.TO_ZERO, _point);
      print('longtap');
      _point = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
//      highlightColor: Colors.deepOrangeAccent[200],
        onTap: _handleTap,
        onDoubleTap: _handleDoubleTap,
        onLongPress: _handleLongTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Ink(
              width: 100,
              height: 100,
              color: Colors.deepOrange[500],
              child: Center(
                child: Text(
                  '$_point',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              )),
        ));
  }
}

class BasicSquareCell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CounterCellState();
}

class BasicSquareCellState extends State<BasicSquareCell> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

//class RandomWordsState extends State<RandomWords> {
//  final _suggestions = <WordPair>[];
//  final _biggerFont = const TextStyle(fontSize: 18.0);
//  final Set<WordPair> _saved = new Set<WordPair>();   // Add this line.
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Startup Name Generator'),
//        actions: <Widget>[      // Add 3 lines from here...
//          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
//        ],
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//
//  Widget _buildSuggestions() {
//    return ListView.builder(
//        padding: const EdgeInsets.all(16.0),
//        itemBuilder: /*1*/ (context, i) {
//          if (i.isOdd) return Divider(); /*2*/
//
//          final index = i ~/ 2; /*3*/
//          if (index >= _suggestions.length) {
//            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//          }
//          return _buildRow(_suggestions[index]);
//        });
//  }
//
//  Widget _buildRow(WordPair pair) {
//    final bool alreadySaved = _saved.contains(pair);  // Add this line.
//    return ListTile(
//      title: Text(
//        pair.asPascalCase,
//        style: _biggerFont,
//      ),
//      trailing: new Icon(   // Add the lines from here...
//        alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved ? Colors.red : null,
//      ),
//      onTap: () {      // Add 9 lines from here...
//        setState(() {
//          if (alreadySaved) {
//            _saved.remove(pair);
//          } else {
//            _saved.add(pair);
//          }
//        });
//      },
//    );
//  }
//
//  void _pushSaved() {
//    Navigator.of(context).push(
//      new MaterialPageRoute<void>(   // Add 20 lines from here...
//        builder: (BuildContext context) {
//          final Iterable<ListTile> tiles = _saved.map(
//                (WordPair pair) {
//              return new ListTile(
//                title: new Text(
//                  pair.asPascalCase,
//                  style: _biggerFont,
//                ),
//              );
//            },
//          );
//          final List<Widget> divided = ListTile
//              .divideTiles(
//            context: context,
//            tiles: tiles,
//          )
//              .toList();
//          return new Scaffold(         // Add 6 lines from here...
//            appBar: new AppBar(
//              title: const Text('Saved Suggestions'),
//            ),
//            body: new ListView(children: divided),
//          );
//        },
//      ),                           // ... to here.
//    );
//  }
//}
//
//class RandomWords extends StatefulWidget {
//  @override
//  RandomWordsState createState() => new RandomWordsState();
//}
//

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have clicked the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
