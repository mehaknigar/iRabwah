import 'dart:async';
import 'package:irabwah/Cart/cartController.dart';
import 'package:irabwah/bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
 
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<CartController>(
        builder: (context) => CartController(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'iRabwah',
          home: SplashScreen(),

        ),
      );
   
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void finish() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => BottomBar(),
      ),
    );
  }
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2 ), finish);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/splash.png',
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
        ],
      ),
    );
  }
}
