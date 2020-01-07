import 'package:flutter/material.dart';
import 'package:irabwah/Models/datatype_one.dart';
import 'package:http/http.dart' as http;
import 'package:irabwah/widgets/datatile.dart';
import 'dart:convert';

class Bakers extends StatefulWidget {
  @override
  _BakersState createState() => _BakersState();
}

class _BakersState extends State<Bakers> {
  Future<List<DataTypeTwo>> getData() async {
    
    var data = await http.get('http://app.irabwah.com/app_data/flutter/bakers.json');

    var jsonData = json.decode(data.body);

    List<DataTypeTwo> list = [];

    for (var u in jsonData) {
      DataTypeTwo i = DataTypeTwo(u["id"], u["name"], u["contact"]);

      list.add(i);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Sweet And Bakers'),
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
                          return DataTile(snapshot.data[index]);
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
