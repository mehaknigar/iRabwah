import 'package:flutter/material.dart';
import 'package:irabwah/Models/datatype_one.dart';
import 'package:http/http.dart' as http;
import 'package:irabwah/widgets/card_data.dart';
import 'dart:convert';

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  Future<List<DataTypeOne>> getData() async {
    var data = await http.get('http://app.irabwah.com/app_data/flutter/restaurants.json');

    var jsonData = json.decode(data.body);

    List<DataTypeOne> list = [];

    for (var u in jsonData) {
      DataTypeOne i = DataTypeOne(
          u["id"], u["logo"], u["name"], u["address"], u["contact"]);

      list.add(i);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Restaurants'),
        centerTitle: true,
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(
          "images/backround2.jpg",
          fit: BoxFit.fill,
        ), Container(
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
                        return CardData(snapshot.data[index]);
                      },
                    );
            },
          ),
        ),
       ] ),
    );
  }
}
