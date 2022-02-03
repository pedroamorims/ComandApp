import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  const DrawerTile({Key? key, required this.icon, required this.text, required this.pageController, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: SizedBox(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: pageController.page?.round() == page
                    ? Colors.white
                    : Colors.black,
              ),
              const SizedBox(
                width: 32.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: pageController.page?.round() == page
                      ? Colors.white
                      : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
