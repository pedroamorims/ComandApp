import 'package:comandapp/models/comanda_model.dart';
import 'package:comandapp/tiles/precomanda_tile.dart';
import 'package:comandapp/widgets/precomanda_price.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PreComandaScreen extends StatefulWidget {
  const PreComandaScreen({Key? key}) : super(key: key);

  @override
  State<PreComandaScreen> createState() => _ComandaScreenState();

}

class _ComandaScreenState extends State<PreComandaScreen> {
  bool pedidofeito = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comanda"),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<ComandaModel>(
                builder: (context, child, model) {
              int? p = model.pedidos.length;
              return Text(
                p == 1 ? "$p ITEM" : "$p ITENS",
                style: const TextStyle(fontSize: 17),
              );
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<ComandaModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.pedidos.isEmpty) {
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
                        children: model.pedidos.map((comanda) {
                          return PreComandaTile(comandaproduto: comanda);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const PreComandaPrice(),
                !pedidofeito
                    ? SizedBox(
                        height: 44.0,
                        child: MaterialButton(
                          onPressed: ComandaModel.of(context).pedidos.isNotEmpty
                              ? () {
                                  ComandaModel.of(context).addComandaFirebase();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("Pedidos realizados com Sucesso"),

                                  ));
                                  ComandaModel.of(context).pedidos.clear();
                                  ComandaModel.of(context).loadComandaProdutos();
                                  ComandaModel.of(context).updateTotal();
                                  setState(() {
                                    pedidofeito = true;
                                  });

                                  Navigator.of(context).pop();

                                }
                              : null,
                          child: const Text(
                            "Confirmar Pedidos?",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                        ))
                    : const SizedBox()
              ],
            );
          }
        },
      ),
    );
  }
}
