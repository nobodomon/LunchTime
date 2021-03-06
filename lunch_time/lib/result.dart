import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Model.dart';
import 'package:LunchTime/Assets/commonAssets.dart';

class Result extends StatefulWidget{
  Result(this.result);
  List<int> result;
  @override
  State<StatefulWidget> createState() => new ResultState(result);
}

class ResultState extends State<Result>  with SingleTickerProviderStateMixin,TickerProviderStateMixin {
  ResultState(this.result);
  List<int> result;
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  List<DocumentSnapshot> selectedPlaces;
  TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.5, curve: Curves.decelerate),
    ));
    _backScale = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.decelerate),
    );
  }
  Widget loadImage(String path, double heightwidth){
    if(path == null){
      return new Container(
        child: Image.asset("lib/Assets/shop.png", width: heightwidth, height: heightwidth,)
      );
    }
    return new Container(
      child: Image.asset(path, width: heightwidth, height: heightwidth,)
    );
  }

  void toggle(){
    setState(() {
      if (_controller.isCompleted || _controller.velocity > 0)
        _controller.reverse();
      else
        _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {

    MaterialAccentColor fontColor;
    List<String> collectionName = new List<String>();
    // TODO: implement build
    print(result.toString());
    return new FutureBuilder(
      future: Firestore.instance.collection("Canteens").getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return new myLoader();
        }else{
          List<DocumentSnapshot> list =  snapshot.data.documents;
          for(int i = 0; i<result.length;i++){
            if(result[i] == 1){
            collectionName.add("stores");
            
            }else{
              collectionName.add("Stores");
            }
          }
          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.greenAccent,
              elevation: 1.0,
              title: new Text("Rolled "+ result.toString()),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.info_outline, color: Colors.white,),
                  onPressed: (){
                    showDialog(
                    context: context,
                    builder:(_)=> AlertDialog(
                      
                      title: new Text("Roll info", style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0
                      ),),
                      content: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          new ListTile(
                            title:new Text(result[0].toString(), style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 25.0
                            ),),
                            subtitle: new Text(list[result[0]].data["CanteenName"], style: new TextStyle(color: Colors.black),),
                          ),
                          new Divider(),
                          new ListTile(
                            title:new Text(result[1].toString(), style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 25.0
                            ),),
                            subtitle: new Text(list[result[1]].data["CanteenName"], style: new TextStyle(color: Colors.black),),
                          ),
                          new Divider(),

                          new ListTile(
                            title:new Text(result[2].toString(), style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 25.0
                            ),),
                            subtitle: new Text(list[result[2]].data["CanteenName"], style: new TextStyle(color: Colors.black),),
                          ),
                        ]
                      ),
                    )
                  );}
                ),
              ],
            ),
            body:TabBarView(
              controller: _tabController,
              children: <Widget>[
                pageResult(context, snapshot, result[0].toString(), collectionName[0]),
                
                pageResult(context, snapshot, result[1].toString(), collectionName[1]),
                
                pageResult(context, snapshot, result[2].toString(), collectionName[2])
              ],
            )
          );
        }
      },
    );
  }
  Widget pageInit(){

  }
  Widget pageResult(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,String canteenID, String collectionName){
    
    MaterialAccentColor fontColor;
    return new StreamBuilder(
      stream: Firestore.instance.collection("Canteens").document(canteenID).snapshots(),
      builder: (BuildContext ct1, AsyncSnapshot<DocumentSnapshot> ss){
        if(ss.hasData){
          return new FutureBuilder(
            future: ss.data.reference.collection(collectionName).getDocuments(),
            builder: (BuildContext ct2, AsyncSnapshot<QuerySnapshot> ss2){
              if(ss2.hasData){
                selectedPlaces = ss2.data.documents;
                print(selectedPlaces.length);
                return new Scaffold(
                  appBar: new AppBar(
                    elevation: 1.0,
                    backgroundColor: Colors.white,
                    /* leading: IconButton(
                      icon: new Icon(Icons.arrow_downward, color: Colors.greenAccent,),
                      onPressed: ()=>Navigator.pop(context),
                    ), */
                    bottom: PreferredSize(
                      child:Padding(
                        padding: new EdgeInsets.fromLTRB(40.0,0.0,40.0,40.0),
                        child: Text(ss.data["CanteenName"], style: Theme.of(context).textTheme.display3,),
                      ),
                      preferredSize: Size(0.0,80.0),
                    ),
                    actions: <Widget>[
                      new Row(children: <Widget>[
                        new Text("Air Conditioned? - ", style: TextStyle(color: Colors.greenAccent),),
                        new Text(ss.data["Aircon"].toString(), style: TextStyle(color: Colors.greenAccent),),
                      ],),
                      new IconButton(
                        icon: new Icon(Icons.shuffle, color: Colors.greenAccent,),
                        onPressed: (){
                          var rng = new Random();
                          int randomIndex = rng.nextInt(selectedPlaces.length);
                          MaterialAccentColor randomIndexedColor;
                          DocumentSnapshot rando = selectedPlaces[randomIndex];
                            var randomedStore = Store.fromSnapshot(rando);
                            switch(randomedStore.price.length){
                              case 1: randomIndexedColor = Colors.greenAccent;
                                      break;
                              case 2: randomIndexedColor = Colors.amberAccent;
                                      break;
                              case 3: randomIndexedColor = Colors.redAccent;
                                      break;
                            }
                            showDialog(
                            context: context,
                            builder:(_)=> AlertDialog(
                              title: new Text("Still Unsure What To Eat?", style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20.0
                              ),),
                              content: new Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  new ListTile(
                                    dense: false,
                                    leading: loadImage(randomedStore.image, 50.0),
                                    title:new Text(randomedStore.storeName+ " seems like a good choice today.", style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                      fontSize: 20.0
                                    ),),
                                    subtitle: new Text(randomedStore.price, style: TextStyle(
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic,
                                      color: randomIndexedColor,
                                    ),),
                                  ),
                                  new Divider(),
                                ]
                              ),
                            )
                          );
                        }
                      ),
                      new IconButton(
                        icon: new Icon(Icons.info_outline, color: Colors.greenAccent,),
                        onPressed: (){
                          showDialog(
                          context: context,
                          builder:(_)=> AlertDialog(
                            
                            title: new Text("Legend", style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 25.0
                            ),),
                            content: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                new ListTile(
                                  title:new Text("\$", style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.greenAccent,
                                    fontSize: 35.0
                                  ),),
                                  subtitle: new Text("\$1.00~\$3.50"),
                                ),
                                new Divider(),
                                new ListTile(
                                  title:new Text("\$\$", style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.amberAccent,
                                    fontSize: 35.0
                                  ),),
                                  subtitle: new Text("\$3.50~\$4.50"),
                                ),
                                new Divider(),

                                new ListTile(
                                  title:new Text("\$\$\$", style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.redAccent,
                                    fontSize: 35.0
                                  ),),
                                  subtitle: new Text("\$4.50~"),
                                ),
                              ]
                            ),
                          )
                        );}
                      ),
                      
                    ],
                  ),
                  body: GridView.builder(
                    
                    itemCount: selectedPlaces.length,
                    
                    padding: new EdgeInsets.all(15.0),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder:(context, index){
                      
                      DocumentSnapshot rando = selectedPlaces[index];
                      var curr = Store.fromSnapshot(rando);
                      switch(curr.price.length){
                        case 1: fontColor = Colors.greenAccent;
                                break;
                        case 2: fontColor = Colors.amberAccent;
                                break;
                        case 3: fontColor = Colors.redAccent;
                                break;
                      }
                      return Card(
                        
                        margin: new EdgeInsets.all(7.5),
                        child: new Center(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              new Text(curr.storeName, style: new TextStyle(fontSize:20.0),),
                              new Divider(),
                              new Padding(
                                padding: new EdgeInsets.all(7.5),
                                child: new Stack(
                                  alignment: Alignment(0.0,0.0),
                                  children:[
                                    new AnimatedBuilder(
                                      child: new RawMaterialButton(
                                        constraints: new BoxConstraints(
                                          minWidth: 110.0,
                                          minHeight: 110.0,
                                          maxHeight: 110.0,
                                          maxWidth: 110.0
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        onPressed: ()=>toggle(),
                                        child: loadImage(curr.image, 75.0),
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
                                      animation: _frontScale,
                                      builder: (BuildContext context, Widget child) {
                                        final Matrix4 transform = new Matrix4.identity()
                                          ..scale(1.0, _frontScale.value, 1.0);
                                        return new Transform(
                                          transform: transform,
                                          alignment: FractionalOffset.center,
                                          child: child,
                                        );
                                      },
                                    ),
                                    new AnimatedBuilder(
                                      child: new RawMaterialButton(
                                        constraints: new BoxConstraints(
                                          minWidth: 110.0,
                                          minHeight: 110.0,
                                          maxHeight: 110.0,
                                          maxWidth: 110.0
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        onPressed: ()=>toggle(),
                                        child: new Text(curr.price, style: new TextStyle(color: fontColor, fontSize: 50.0, fontStyle: FontStyle.italic),),
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
                                      animation: _backScale,
                                      builder: (BuildContext context, Widget child) {
                                        final Matrix4 transform = new Matrix4.identity()
                                          ..scale(1.0, _backScale.value, 1.0);
                                        return new Transform(
                                          transform: transform,
                                          alignment: FractionalOffset.center,
                                          child: child,
                                        );
                                      },
                                    )
                                  ]
                                ),
                              )
                            ]),
                        ),
                      );
                    }
                  )
                );
        
              }else{
                return myLoader();
              }
          });
        }else{
          return new myLoader();
        }
      }
    );
  }
}