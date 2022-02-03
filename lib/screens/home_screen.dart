import 'package:comandapp/models/comanda_model.dart';
import 'package:comandapp/screens/comanda_screen.dart';
import 'package:comandapp/tabs/home_tab.dart';
import 'package:comandapp/tabs/category_tab.dart';
import 'package:comandapp/widgets/comanda_button.dart';
import 'package:comandapp/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body:  HomeTab(pageController: _pageController),
          drawer: CustomDrawer(pageController: _pageController),
          floatingActionButton: const ComandaButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Cardápio"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: const CategoryTab(),
          floatingActionButton: const ComandaButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Pedidos Realizados"),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 8.0),
                alignment: Alignment.center,
                child: ScopedModelDescendant<ComandaModel>(
                    builder: (context, child, model) {
                  int? p = model.pedidosconfirmados.length;
                  return Text(
                    p == 1 ? "$p ITEM" : "$p ITENS",
                    style: const TextStyle(fontSize: 17),
                  );
                }),
              )
            ],
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: const ComandaScreen(),
        ),
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }
}
