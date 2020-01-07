import 'package:flutter/material.dart';
import '../Models/datatype_one.dart';
import 'package:url_launcher/url_launcher.dart';

class DataTile extends StatelessWidget {
  final DataTypeTwo data;

  DataTile(this.data);

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text(data.name),
            leading: Text(
              data.id.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            subtitle: Center(
              child: RaisedButton(
                color: Colors.red,
                child: Text(
                  data.contact,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => launchURL('tel:${data.contact}'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
