import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:irabwah/NewsPage.dart';
import 'Models/news.dart';



class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  Future<List<NewsModel>> getData() async {
    var data = await http.get('http://app.irabwah.com/app_data/jsons/json_irabwah.php');

    var jsonData = json.decode(data.body);

    List<NewsModel> myData = [];

    for (var u in jsonData) {
      NewsModel myDataSingle = NewsModel(
          u["id"], u["Date"], u["Title"], u["Name"],
           u["Content"],u['url'],u['description'],u["img_url"]);

      myData.add(myDataSingle);
    }

    return myData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/backround2.jpg',
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return NewsBox(snapshot.data[index]);
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}

class NewsBox extends StatelessWidget {
  final NewsModel data;

  NewsBox(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NewsPage(data),
            ),
          );
        },
        child: Card(
         
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                    tag: data.id,
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(data.titleImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,16,16,1),
                    child: Text(
                      data.title!=null? data.title:"NO title",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                       Text(data.description
                       ,overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Text(
                          data.date,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
