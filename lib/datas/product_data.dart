import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/datas/size_data.dart';

class ProductData{

  String? category;
  String? id;
  String? title;
  String? description;

  SizeData? sizes;

  List? images;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot["title"];
    description = snapshot["description"];
    images = snapshot["images"];

  }

  Map<String , dynamic> toResumedMap(){
    return{
      "title" : title,
      "description" : description
    };
  }


}