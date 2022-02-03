import 'package:comandapp/datas/product_data.dart';
import 'package:comandapp/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  const ProductTile({Key? key, required this.product, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductScreen(product: product)));
      },
      child: Card(
          child: type == "grid"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        product.images![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.title.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              //  "R\$ ${product.price![0].toStringAsFixed(2)}",
                              product.description!,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                )
              : Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.network(
                        product.images![0],
                        fit: BoxFit.cover,
                        height: 250.0,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              product.description!,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
    );
  }
}
