import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'categories/mainCategory.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(
          "images/backround2.jpg",
          fit: BoxFit.fill,
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: size.width,
                  child: Image.asset(
                    "images/Logo.png",
                    width: size.width,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: null,
            )),
            Expanded(
              flex: 2,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: MainCategory()),
                    );
                  },
                  child: Image.asset(
                    "images/SplashLogo.png",
                    width: 200,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: null,
            )),
          ],
        )
      ]),
    );
  }
}
