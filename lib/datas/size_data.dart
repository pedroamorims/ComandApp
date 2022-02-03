import 'package:cloud_firestore/cloud_firestore.dart';

class SizeData{

  String? size;
  String? id;
  double? price;

  SizeData();

  SizeData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    size = snapshot["size"];
    price = snapshot["price"] + 0.0;

  }

  Map<String , dynamic> toResumedMap(){
    return{
      "size" : size,
      "price" : price
    };
  }



}