import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/datas/comanda_produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class ComandaModel extends Model {
  List<ComandaProduto> pedidos = [];
  List<ComandaProduto> pedidosconfirmados = [];

  static ComandaModel of(BuildContext context) => ScopedModel.of<ComandaModel>(context);

  bool isLoading = false;
  String comandaatual = "";



  ComandaModel(){
    loadComandaProdutos();
  }

  void registraComanda(String codigo){
    comandaatual = codigo;
  }

  void addComandaItem(ComandaProduto comandaProduto){
    int? index;
    ComandaProduto jaexistente = ComandaProduto();
    index =  pedidos.indexWhere((element) => ((element.pid == comandaProduto.pid) && (element.sid == comandaProduto.sid)),0);


    if(index == -1){
      pedidos.add(comandaProduto);
    }
    else{
      jaexistente = pedidos[index];
      comandaProduto.quantity = comandaProduto.quantity! + jaexistente.quantity!;

      pedidos[index] = comandaProduto;
    }
    


    notifyListeners();
  }

   void addComandaFirebase(){

    for(ComandaProduto c in pedidos) {
      FirebaseFirestore.instance.collection("comandas").doc("1")
          .collection("pedidos").add(c.toMap()).then((doc) {
        c.cid = doc.id;
      });
    }
    notifyListeners();
  }

  void removeComandaItem(ComandaProduto comandaProduto){
    FirebaseFirestore.instance.collection("comandas").doc("1")
        .collection("pedidos").doc(comandaProduto.cid).delete();

    pedidos.remove(comandaProduto);
    notifyListeners();
  }

  void decProduct(ComandaProduto comandaProduto){
    if(comandaProduto.quantity != null) {
      comandaProduto.quantity = comandaProduto.quantity! - 1;
    }

    FirebaseFirestore.instance.collection("comandas").doc("1")
        .collection("pedidos").doc(comandaProduto.cid).update(comandaProduto.toMap());

    notifyListeners();
  }

  void incProduct(ComandaProduto comandaProduto){
    if(comandaProduto.quantity != null) {
      comandaProduto.quantity = comandaProduto.quantity! + 1;
    }

    FirebaseFirestore.instance.collection("comandas").doc("1")
        .collection("pedidos").doc(comandaProduto.cid).update(comandaProduto.toMap());

    notifyListeners();
  }

  void loadComandaProdutos() async{
    pedidosconfirmados.clear();
    isLoading = true;
    QuerySnapshot query = await FirebaseFirestore.instance.collection("comandas").doc("1")
        .collection("pedidos").get();

    query.docs.map((doc) => ComandaProduto.fromDocument(doc)).forEach((comandaProduto) {
      int? index;
      ComandaProduto jaexistente = ComandaProduto();
      index =  pedidosconfirmados.indexWhere((element) => ((element.pid == comandaProduto.pid) && (element.sid == comandaProduto.sid)),0);

      if(index == -1){
        pedidosconfirmados.add(comandaProduto);
      }
      else{
        jaexistente = pedidosconfirmados[index];
        comandaProduto.quantity = comandaProduto.quantity! + jaexistente.quantity!;

        pedidosconfirmados[index] = comandaProduto;
      }
    });

    isLoading = false;
    notifyListeners();
  }

  double getpreTotal(){
    double price = 0.0;
    for(ComandaProduto c in pedidos){
      if(c.sizedData != null){
        price += c.quantity! * c.sizedData!.price!;
      }
    }

    return price;

  }

  double getTotal(){
    double price = 0.0;
    for(ComandaProduto c in pedidosconfirmados){
      if(c.sizedData != null){
        price += c.quantity! * c.sizedData!.price!;
      }
    }

    return price;

  }

  void updateTotal(){
    notifyListeners();
  }




}