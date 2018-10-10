import 'dart:math';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget{
  Result(this.result);
  int result;
  @override
  State<StatefulWidget> createState() => new ResultState(result);
}

class ResultState extends State<Result>  with TickerProviderStateMixin {
  ResultState(this.result);
  int result;
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  List<String> selectedPlaces;
  List<String> selectedPrices;
  List<String> selectedPictures;
  List<String> foodglePlaces =["Ban mian","Western","Fusion","Yong Tau Foo","Japanese","Thai","Indonesian","Chicken Rice","Mala","菜饭","Taiwan Chicken","Pizza/Salad"];
  List<String> foodglePrices =["\$","\$\$","\$\$\$","\$","\$\$","\$","\$\$\$","\$","\$\$\$","\$\$","\$\$\$","\$\$\$"];
  List<String> foodglePictures =[
    "lib/Assets/noodles.png",
    "lib/Assets/hamburguer.png",
    "lib/Assets/rice.png",
    "lib/Assets/stew-1.png",
    "lib/Assets/sushi-1.png",
    "lib/Assets/chili.png",
    "lib/Assets/meat-1.png",
    "lib/Assets/meat.png",
    "lib/Assets/chili.png",
    "lib/Assets/rice.png",
    "lib/Assets/meat.png",
    "lib/Assets/salad.png"];
  List<String> southPlaces= ["Vegetarian","Malay rice","Chicken Rice","Noodle","Japanese","Ban Mian","菜饭","Western","Briyani"];
  List<String> southPrices =["\$","\$","\$","\$","\$","\$","\$\$","\$\$","\$"];
  List<String> southPictures =[
    "lib/Assets/salad-1.png",    
    "lib/Assets/rice.png",
    "lib/Assets/meat.png",
    "lib/Assets/noodles.png",
    "lib/Assets/sushi-1.png",
    "lib/Assets/noodles.png",    
    "lib/Assets/rice.png",
    "lib/Assets/hamburguer.png",
    "lib/Assets/risotto.png",
  ];
  List<String> koufuPlaces =["Thai","Malay","Korean","Noodle","Curry rice/Hotpot","Yong Tau Foo","Kebab","Vegetarian","Mala","Japanese","Dim Sum","Western"];
  List<String> koufuPrices =["\$","\$\$","\$\$","\$","\$\$\$","\$","\$\$\$","\$","\$\$\$","\$\$","\$"];
  List<String> koufuPictures =[
    "lib/Assets/chili.png",  
    "lib/Assets/rice.png",  
    "lib/Assets/cabbage.png",
    "lib/Assets/noodles.png",
    "lib/Assets/stew-1.png",
    "lib/Assets/stew-1.png",
    "lib/Assets/kebab-2.png",
    "lib/Assets/salad-1.png", 
    "lib/Assets/chili.png", 
    "lib/Assets/sushi-1.png",
    "lib/Assets/food.png",
    "lib/Assets/hamburguer.png",
  ];
  List<String> foodCentralPlaces =["Manna", "Subway","Lok Lok", "Mala", "Salad"];
  List<String> foodCentralPrices =["\$\$\$","\$\$\$","\$\$","\$\$\$","\$\$"];
  List<String> foodCentralPictures =[
    "lib/Assets/hamburguer.png",
    "lib/Assets/sandwich-1.png",
    "lib/Assets/chili.png",
    "lib/Assets/chili.png",
    "lib/Assets/salad.png",
  ];
  List<String> northPlaces =["Malay Rice", "Malay Noodle", "Pasta","Chicken Rice","Western","Ban Mian", "Vegetarian","菜饭", "BBQ Food","Indian","Salad"];
  List<String> northPrices =["\$","\$","\$\$","\$","\$\$","\$","\$","\$\$","\$","\$\$\$","\$\$"];
  List<String> northPictures =[
    "lib/Assets/rice.png",  
    "lib/Assets/noodles.png",  
    "lib/Assets/pasta-1.png",  
    "lib/Assets/meat.png",  
    "lib/Assets/hamburguer.png",
    "lib/Assets/noodles.png",
    "lib/Assets/salad-1.png",
    "lib/Assets/rice.png",
    "lib/Assets/pan.png",
    "lib/Assets/risotto.png",
    "lib/Assets/salad.png",
  ];
  List<String> places = ["Foodgle","South Canteen","Koufu","Food Connect","North Canteen"];
  @override
  void initState() {
    super.initState();
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


    
    switch(result){
      case 0: selectedPlaces = foodglePlaces;
              selectedPrices = foodglePrices;
              selectedPictures = foodglePictures;
              break;
      
      case 1: selectedPlaces = southPlaces;
              selectedPrices = southPrices;
              selectedPictures = southPictures;
              break;

      case 2: selectedPlaces = koufuPlaces;
              selectedPrices = koufuPrices;
              selectedPictures = koufuPictures;
              break;

      case 3: selectedPlaces = foodCentralPlaces;
              selectedPrices = foodCentralPrices;
              selectedPictures = foodCentralPictures;
              break;

      case 4: selectedPlaces = northPlaces;
              selectedPrices = northPrices;
              selectedPictures = northPictures;
              break;
    }
    MaterialAccentColor fontColor;
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        elevation: 3.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: new Icon(Icons.arrow_downward, color: Colors.greenAccent,),
          onPressed: ()=>Navigator.pop(context),
        ),
        bottom: PreferredSize(
          child:Padding(
            padding: new EdgeInsets.fromLTRB(40.0,0.0,40.0,40.0),
            child: Text(places[result], style: Theme.of(context).textTheme.display3,),
          ),
          preferredSize: Size(0.0,80.0),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.shuffle, color: Colors.greenAccent,),
            onPressed: (){
              var rng = new Random();
              int randomIndex = rng.nextInt(selectedPlaces.length);
              MaterialAccentColor randomIndexedColor;
              switch('${selectedPrices[randomIndex]}'.length){
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
                      leading: loadImage(selectedPictures[randomIndex], 50.0),
                      title:new Text('${selectedPlaces[randomIndex]}'+ " seems like a good choice today.", style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 20.0
                      ),),
                      subtitle: new Text('${selectedPrices[randomIndex]}', style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: randomIndexedColor,
                      ),),
                    ),
                    new Divider(),
                  ]
                ),
              )
            );}
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
          switch('${selectedPrices[index]}'.length){
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
                  new Text('${selectedPlaces[index]}', style: new TextStyle(fontSize:20.0),),
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
                            child: loadImage(selectedPictures[index], 75.0),
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
                            child: new Text('${selectedPrices[index]}', style: new TextStyle(color: fontColor, fontSize: 50.0, fontStyle: FontStyle.italic),),
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
  }
}