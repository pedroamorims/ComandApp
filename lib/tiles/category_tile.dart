import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/screens/listproducts_screen.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  const CategoryTile({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        foregroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot["icon"]),
      ),
      title: Text(snapshot["title"]),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ListProductsScreen(snapshot: snapshot,))
        );
      },
    );
  }
}
