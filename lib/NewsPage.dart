import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'Models/news.dart';
import 'package:url_launcher/url_launcher.dart';

const String startHtml =
    '<html><head><style>p{font-size:5px;text-align:justify;color:#000;}img{display:block;margin:11px auto;}</style></head><body>';
const String endHtml = '</p></html>';

class NewsPage extends StatelessWidget {
  final NewsModel data;
  NewsPage(this.data);

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Hero(
                tag: data.id,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  child: Image(
                    image: CachedNetworkImageProvider(data.titleImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 220, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.title,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(data.date),
                    Divider(
                      thickness: 5,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    HtmlWidget(
                      startHtml + data.content + endHtml,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 20.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.open_in_new),
                        onPressed: () => launchURL('${data.url}'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
