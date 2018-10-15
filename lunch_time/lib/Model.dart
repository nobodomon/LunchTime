import 'package:cloud_firestore/cloud_firestore.dart';

class Store{
  String storeName;
  String price;
  String image;
  Store(this.storeName,this.price,this.image);

  Store.fromSnapshot(DocumentSnapshot snapshot){
    this.storeName = snapshot.documentID;
    this.price = snapshot["price"];
    this.image = snapshot["image"];
  }  
}