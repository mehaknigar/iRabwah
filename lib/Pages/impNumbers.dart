import 'package:flutter/material.dart';
import 'package:irabwah/Models/numberModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Numbers extends StatefulWidget {
  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  Future<List<Number>> getData() async {
    var data =
        await http.get('http://app.irabwah.com/app_data/flutter/importantNumbers.json');

    var jsonData = json.decode(data.body);

    List<Number> list = [];

    for (var u in jsonData) {
      Number i = Number(u["id"], u["name"], u["contact"]);

      list.add(i);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Numbers'),
        centerTitle: true,
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
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
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return DataTile1(snapshot.data[index]);
                      },
                    );
            },
          ),
        ),
      ]),
    );
  }
}

class DataTile1 extends StatelessWidget {
  final Number data;

  DataTile1(this.data);

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () => launchURL('tel:${data.contact}'),
                  child: Text(data.contact,
                  
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          letterSpacing: .3,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
