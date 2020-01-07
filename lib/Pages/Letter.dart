import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irabwah/Models/LetterModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:expand_widget/expand_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Letter extends StatefulWidget {
  @override
  _LetterState createState() => _LetterState();
}

class _LetterState extends State<Letter> {
  Future<List<Letter1>> getData() async {


    var data = await http.get('http://app.irabwah.com/app_data/flutter/newsletter.json');

    var jsonData = json.decode(data.body);

    List<Letter1> list = [];

    for (var u in jsonData) {
      Letter1 i = Letter1(u["id"], u["logo"], u["pdf"]);

      list.add(i);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('News Letter'),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "images/backround2.jpg",
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return NewsLetter(snapshot.data[index]);
                          },
                        );
                },
              ),
            ),
          ],
        ));
  }
}

class NewsLetter extends StatelessWidget {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Letter1 data;
  NewsLetter(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: data.logo,
                    placeholder: (context, url) => Container(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        height: 20,
                        width: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              ExpandChild(
                child: OutlineButton(
                  child: Text(
                    'View',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    launchURL(data.pdf);
                  },
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
