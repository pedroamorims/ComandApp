import 'package:comandapp/models/comanda_model.dart';
import 'package:comandapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ScopedModel<ComandaModel>(
      model: ComandaModel(),
      child: MaterialApp(
        title: 'ComandApp',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }

}






