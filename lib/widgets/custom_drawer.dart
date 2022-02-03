import 'package:comandapp/models/comanda_model.dart';
import 'package:comandapp/tiles/drawer.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer({Key? key, required this.pageController}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 20, 20),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    const Positioned(
                      child: Text(
                        "Avalanches",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      top: 8.0,
                      left: 0.0,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          const Text(
                            "Olá",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ComandaModel.of(context).comandaatual == "" ? GestureDetector(
                            child: const Text(
                              "Iniciar Comanda >",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: (){

                            },
                          ):
                          Text(
                            "Comanda: ${ComandaModel.of(context).comandaatual}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawerTile(icon: Icons.home, text: "Início", pageController:  pageController,page: 0),
              ComandaModel.of(context).comandaatual != "" ? DrawerTile(icon: Icons.list, text: "Cardápio",pageController:  pageController,page: 1) : const SizedBox(),
              ComandaModel.of(context).comandaatual != "" ? DrawerTile(icon: Icons.playlist_add_check, text: "Meus Pedidos",pageController:  pageController,page: 2) : const SizedBox(),
             // DrawerTile(icon: Icons.price_check_rounded, text: "Fechar Conta",pageController:  pageController,page: 3),

            ],
          )
        ],
      ),
    );
  }
}
