import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tem Certeza?'),
        content: const Text('Que quer fechar o aplicativo?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sim'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("products").get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          else{
            var dividedTiles = ListTile.divideTiles(tiles: snapshot.data!.docs.map((doc) {
              return CategoryTile(snapshot: doc);
            }).toList(), color: Theme.of(context).primaryColor).toList();
            return ListView(
              children: dividedTiles
            );
          }
        },
      ),
    );
  }
}
