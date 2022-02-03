import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/datas/product_data.dart';
import 'package:comandapp/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class ListProductsScreen extends StatelessWidget {
  final DocumentSnapshot? snapshot;

  const ListProductsScreen({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ProductData produto;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              snapshot!["title"],
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("products")
                .doc(snapshot?.id)
                .collection("itens")
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.all(4.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65
                      ),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index){
                        produto = ProductData.fromDocument(snapshot.data!.docs[index]);
                        produto.category = this.snapshot?.id;
                        return ProductTile(type: "grid",product: produto);
                      },
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(4.0),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index){
                        produto = ProductData.fromDocument(snapshot.data!.docs[index]);
                        produto.category = this.snapshot?.id;
                        return ProductTile(type: "list", product: produto);           },
                    ),

                  ],
                );
              }
            },
          )),
    );
  }
}





