import 'package:flutter/material.dart';
import 'dart:math';
import 'result.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
      bodyColor: Colors.green,
      displayColor: Colors.greenAccent,
    );
    
    return new MaterialApp(
      title: 'LunchTime',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        textTheme: newTextTheme,
        buttonColor: Colors.green,
      ),
      home: new MyHomePage(title: 'Lunch Time'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String placeToEat = "Press button";
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    viewResult(){
      var rng = new Random();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Result(rng.nextInt(5))
          )
        );
    }
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          widget.title, 
          style: new TextStyle(
            color: Colors.green,
        ),),
      ),
      body: new Center(
        child: new Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Where are we eating today:',
              style: Theme.of(context).textTheme.display1,
            ),
            new Padding(
              padding: new EdgeInsets.all(15.0)
            ),
            new RawMaterialButton(
              constraints: new BoxConstraints(
                minWidth:250.0,
                minHeight:250.0,
                maxWidth:250.0,
                maxHeight:250.0
              ),
              onPressed: ()=> viewResult(),
              child: new Text(
                "Help me decide!",
                style: new TextStyle(
                  fontSize: 24.0
                ),
              ),
              shape: new CircleBorder(
                side: BorderSide(
                  color: Colors.greenAccent,
                  width: 2.0
                )
              ),
              elevation: 2.0,
              fillColor: Colors.white,
              splashColor: Colors.greenAccent,
          ),
          ],
        ),
      ),
    );
  }
}
