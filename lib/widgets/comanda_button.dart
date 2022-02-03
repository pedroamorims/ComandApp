import 'package:comandapp/screens/precomanda_screen.dart';
import 'package:flutter/material.dart';

class ComandaButton extends StatelessWidget {
  const ComandaButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const PreComandaScreen()));
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
