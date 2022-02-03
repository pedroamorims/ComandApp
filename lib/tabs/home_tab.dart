import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/models/comanda_model.dart';
import 'package:comandapp/widgets/qrcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatefulWidget {
  final PageController pageController;

  const HomeTab({Key? key, required this.pageController}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool imagenscarregadas = false;

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() =>
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 255, 70, 70),
                Color.fromARGB(255, 255, 100, 100)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return ScopedModelDescendant<ComandaModel>(
      builder: (context, child, model) =>
          Stack(
              children: [
              _buildBodyBack(),
      CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          const SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Bem Vindo!'),
              centerTitle: true,
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("home")
                .orderBy("pos")
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: 200.0,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              } else {
                imagenscarregadas = true;
                return SliverStaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  staggeredTiles: snapshot.data!.docs.map((doc) {
                    return StaggeredTile.count(doc["x"], doc["y"]);
                  }).toList(),
                  children: snapshot.data!.docs.map((doc) {
                    return FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: doc["image"],
                      fit: BoxFit.cover,
                    );
                  }).toList(),

                );
              }
            },
          ),
        ],
      ),
      imagenscarregadas ?
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: model.comandaatual == ""
              ? ButtonTheme(
              height: 60.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRCodeScanner(),
                  ));
                },
                child: const Text(
                  "Iniciar Comanda",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ), //Text
              )
            //RaisedButton
          ) : ButtonTheme(
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  widget.pageController.jumpToPage(1);
                },
                child: const Text(
                  "Fazer Pedido",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ), //Text
              )
            //RaisedButton
          ),
        ),
      ) :
      const SizedBox(),
      ],
    ),);
  }
}
