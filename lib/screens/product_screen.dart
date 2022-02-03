import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandapp/datas/comanda_produto.dart';
import 'package:comandapp/datas/product_data.dart';
import 'package:comandapp/datas/size_data.dart';
import 'package:comandapp/models/comanda_model.dart';
import 'package:comandapp/screens/precomanda_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  SizeData sizes = SizeData();



  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title!),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              options: CarouselOptions(autoPlay: false),
              items: widget.product.images?.map((url) {
                return Image.network(url);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product.title!,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  sizes.price == null
                      ? "Selecione um tamanho!"
                      : "R\$ ${sizes.price?.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("products")
                        .doc(widget.product.category)
                        .collection("itens")
                        .doc(widget.product.id)
                        .collection("tamanho")
                        .orderBy("price")
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return GridView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 0.5),
                            children: snapshot.data!.docs.map((s) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sizes.size = s["size"];
                                    sizes.price = s["price"] + 0.0;
                                    sizes.id = s.id;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    border: Border.all(
                                        color: s["size"] == sizes.size
                                            ? Colors.red
                                            : Colors.grey[500]!),
                                  ),
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  child: (Text(s["size"])),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: MaterialButton(
                    onPressed: sizes.size != null
                        ? () {
                            ComandaProduto comandaproduto = ComandaProduto();
                            comandaproduto.sizedData = SizeData();
                            comandaproduto.sizedData?.size = sizes.size;
                            comandaproduto.sizedData?.price = sizes.price;
                            comandaproduto.sizedData?.id = sizes.id;
                            comandaproduto.quantity = 1;
                            comandaproduto.pid = widget.product.id;
                            comandaproduto.category = widget.product.category;
                            comandaproduto.productData = widget.product;
                            comandaproduto.sid = sizes.id;

                            ComandaModel.of(context).addComandaItem(comandaproduto);

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PreComandaScreen()));


                          }
                        : null,
                    child: const Text(
                      "Adicionar à Comanda",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.product.description!,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
