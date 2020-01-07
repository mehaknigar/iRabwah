import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:irabwah/categories/SubCatgories/subProducts.dart';

class Occasion extends StatefulWidget {
  @override
  _OccasionState createState() => _OccasionState();
}

class _OccasionState extends State<Occasion> {
  List data = [];
  void initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    var response =
        await http.get('http://app.irabwah.com/app_data/Categories/occasions.php');
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Occasions'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Image.asset(
            "images/backround2.jpg",
            fit: BoxFit.fill,
          ),data.length==0 ? 
                          Center(
                          child: CircularProgressIndicator(),
                          
                        ):
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, index) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubProduct(data[index]['id'],data[index]['name']),
                            ),
                          );
                        },
                        child: Container(
                          height: 80,
                          child: Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Row(children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'images/Occasions.png'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  data[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black87),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ]));
  }
}
