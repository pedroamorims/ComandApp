import 'package:comandapp/models/comanda_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ComandaPrice extends StatelessWidget {
  const ComandaPrice({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: ScopedModelDescendant<ComandaModel>(
          builder: (context, child, model) {
             double price = model.getTotal();


            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Resumo",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
