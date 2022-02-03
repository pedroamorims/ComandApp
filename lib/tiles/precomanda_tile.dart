import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/datas/comanda_produto.dart';
import 'package:comandapp/datas/product_data.dart';
import 'package:comandapp/models/comanda_model.dart';
import 'package:flutter/material.dart';

class PreComandaTile extends StatelessWidget {
  final ComandaProduto comandaproduto;

  const PreComandaTile({Key? key, required this.comandaproduto}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<DocumentSnapshot> getProdutos() async {

      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection("products")
          .doc(comandaproduto.category)
          .collection("itens")
          .doc(comandaproduto.pid)
          .get();

      return ds;
    }



    Widget _buildContent() {
      ComandaModel.of(context).updateTotal();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              comandaproduto.productData!.images![0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  comandaproduto.productData?.title ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
                Text(
                  "Tamanho: ${comandaproduto.sizedData?.size ?? "0ML"}",
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  "R\$ ${comandaproduto.sizedData?.price?.toStringAsFixed(2) ?? "1000"}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: comandaproduto.quantity! > 1
                          ? () {
                              ComandaModel.of(context)
                                  .decProduct(comandaproduto);
                            }
                          : null,
                      icon: const Icon(Icons.remove),
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(comandaproduto.quantity.toString()),
                    IconButton(
                        onPressed: () {
                          ComandaModel.of(context).incProduct(comandaproduto);
                        },
                        icon: const Icon(Icons.add),
                        color: Theme.of(context).primaryColor),
                    TextButton(
                      onPressed: () {
                        ComandaModel.of(context)
                            .removeComandaItem(comandaproduto);
                      },
                      child: const Text("Remover"),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      );
    }

    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: comandaproduto.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                 future: getProdutos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                      comandaproduto.productData =
                        ProductData.fromDocument(snapshot.data!);

                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: const CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                })
            : _buildContent());
  }


}
