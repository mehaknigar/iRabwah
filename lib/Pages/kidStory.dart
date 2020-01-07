import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:irabwah/Models/StoryModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KidsStory extends StatefulWidget {
  @override
  _KidsStoryState createState() => _KidsStoryState();
}

class _KidsStoryState extends State<KidsStory> {
  Future<List<Story1>> getData() async {
    var data = await http.get('http://app.irabwah.com/app_data/flutter/kidStories.json');

    var jsonData = json.decode(data.body);

    List<Story1> list = [];

    for (var u in jsonData) {
      Story1 i = Story1(u["id"], u["name"], u["image"]);

      list.add(i);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Kids Stories'),
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
                        return StoryNames(snapshot.data[index]);
                      },
                    );
            },
          ),
        ),
      ]),
    );
  }
}

class StoryNames extends StatelessWidget {
  final Story1 data1;
  StoryNames(this.data1);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.bookmark,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 6,
                child: Text(
                  data1.name.toUpperCase(),
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryDisplay(data1),
                          ),
                        );
                      },
                      child: Icon(Icons.arrow_forward_ios))),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryDisplay extends StatelessWidget {
  final Story1 data2;
  StoryDisplay(this.data2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data2.name),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Expanded(
            child: Center(
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: data2.image,
                  placeholder: (context, url) => Container(
                    margin: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
