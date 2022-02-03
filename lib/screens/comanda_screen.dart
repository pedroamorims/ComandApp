import 'package:comandapp/models/comanda_model.dart';
import 'package:comandapp/tiles/comanda_tile.dart';
import 'package:comandapp/widgets/comanda_price.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ComandaScreen extends StatefulWidget {
  const ComandaScreen({Key? key}) : super(key: key);
  @override
  State<ComandaScreen> createState() => _ComandaScreenState();
}

class _ComandaScreenState extends State<ComandaScreen> {
  bool pedidofeito = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ScopedModelDescendant<ComandaModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.pedidosconfirmados.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum produto na comanda!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: [
                      Column(
                        children: model.pedidosconfirmados.map((comanda) {
                          return ComandaTile(comandaproduto: comanda);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const ComandaPrice(),
              ],
            );
          }
        },
      ),
    );
  }
}
