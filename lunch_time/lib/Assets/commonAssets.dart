import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class myLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Center(
        child: new Card(
          child: new Padding(
            padding: new EdgeInsets.all(25.0),
            child: new CircularProgressIndicator(),
          ) 
        )
      )
    );
  }
}