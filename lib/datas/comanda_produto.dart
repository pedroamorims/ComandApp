import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/datas/product_data.dart';
import 'package:comandapp/datas/size_data.dart';

class ComandaProduto {

  String? cid;
  String? category;
  String? pid;
  int? quantity;
  String? sid;

  ProductData? productData;
  SizeData? sizedData;

  ComandaProduto();

  ComandaProduto.fromDocument(DocumentSnapshot snapshot){
    cid = snapshot.id;
    category = snapshot["category"];
    pid = snapshot["pid"];
    quantity = snapshot["quantity"];
    sid = snapshot["sid"];

    sizedData = SizeData();
    sizedData?.size =  snapshot["size"]["size"];
    sizedData?.price =  snapshot["size"]["price"] + 0.0;
  }

  Map<String, dynamic> toMap(){
    return{
      "category" : category,
      "pid" : pid,
      "quantity" : quantity,
      "product" : productData?.toResumedMap(),
      "size" : sizedData?.toResumedMap(),
      "sid" : sid
    };
  }

}