import 'package:flutter/material.dart';
import '../Models/datatype_one.dart';
import 'package:url_launcher/url_launcher.dart';


class CardData extends StatelessWidget {
  final DataTypeOne data;

  CardData(this.data);

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              data.logo,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Address:',
                    style: TextStyle(
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(data.address),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    child: Text(
                      data.contact,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => launchURL('tel:${data.contact}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
