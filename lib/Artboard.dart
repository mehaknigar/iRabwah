import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Artboard extends StatefulWidget {
  @override
  _ArtboardState createState() => _ArtboardState();
}

class _ArtboardState extends State<Artboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Image.asset(
        "images/backround2.jpg",
        fit: BoxFit.fill,
      ),
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
          Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(
              height: 130,
              child: Image.asset(
                "images/Logo.png",
                width: size.width,
              ),
            ),
          ),
        ),
        Button('images/facebook.png', 'https://www.facebook.com/iRabwah'),
        Button('images/twitter.png', 'https://twitter.com/irabwah'),
        Button('images/instagram.png', 'https://www.instagram.com/irabwah'),
        
        Button('images/YouTube.png',
            'https://www.youtube.com/channel/UCrzl7tJciUjeXlTNSv98zdA'),
      ]),
    ]));
  }
}

class Button extends StatefulWidget {
  final String image, url;
  Button(this.image, this.url);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlatButton(
        child: Image.asset(
          widget.image,
          width: size.width,
        ),
        onPressed: () {
          setState(() {
            launchURL(widget.url);
          });
        });
  }
}
