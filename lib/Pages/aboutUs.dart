import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  _launchURL() async {
    if (Platform.isIOS) {
      if (await launch(
          'https://www.google.com/maps/place/Skylite+Networks+(Pvt.)+Ltd./@31.7565897,72.9104444,17z/data=!3m1!4b1!4m5!3m4!1s0x39222568c2575dfb:0xfcb52ffa22504c4c!8m2!3d31.7565897!4d72.9126331')) {
        await launch(
            'https://www.google.com/maps/place/Skylite+Networks+(Pvt.)+Ltd./@31.7565897,72.9104444,17z/data=!3m1!4b1!4m5!3m4!1s0x39222568c2575dfb:0xfcb52ffa22504c4c!8m2!3d31.7565897!4d72.9126331');
      } else {
        if (await launch(
            'https://www.google.com/maps/place/Skylite+Networks+(Pvt.)+Ltd./@31.7565897,72.9104444,17z/data=!3m1!4b1!4m5!3m4!1s0x39222568c2575dfb:0xfcb52ffa22504c4c!8m2!3d31.7565897!4d72.9126331')) {
          await launch(
              'https://www.google.com/maps/place/Skylite+Networks+(Pvt.)+Ltd./@31.7565897,72.9104444,17z/data=!3m1!4b1!4m5!3m4!1s0x39222568c2575dfb:0xfcb52ffa22504c4c!8m2!3d31.7565897!4d72.9126331');
        } else {
          throw 'Could not launch https://www.google.com/maps/place/Skylite+Networks+(Pvt.)+Ltd./@31.7565897,72.9104444,17z/data=!3m1!4b1!4m5!3m4!1s0x39222568c2575dfb:0xfcb52ffa22504c4c!8m2!3d31.7565897!4d72.9126331';
        }
      }
    } else {
      const url =
          'https://www.google.com/maps/place/Skylite+Networks+(Pvt.)+Ltd./@31.7565897,72.9104444,17z/data=!3m1!4b1!4m5!3m4!1s0x39222568c2575dfb:0xfcb52ffa22504c4c!8m2!3d31.7565897!4d72.9126331';
      if (await launch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('About Us'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Share.share('http://www.irabwah.com/');
              },
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Divider(),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image.asset('images/Logo.png'),
                          ),
                        ),
                        Divider(
                          height: 5,
                          thickness: 5,
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'Here you will find beautiful gifts to send to your loved ones, family or friends.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'When you think of gifting your loved ones, iRabwah takes care of your gifting need and makes sure that your beloved receive the best to make their day memorable. We deliver a wide range of gifts suitable for any occasions like birthday, wedding, anniversary, friendship, celebrate a new beginning, thank someone, congratulations, to say a sorry – or because you feel like gifting something to your loved ones just like that, So no matter where your loved ones are in Rabwah you can send them your wishes.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            ' For the first time in Rabwah variety of unique services are available exclusively for our Ahmadi brothers.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'We are online 24 hours 7 days a week so if you have any questions or need help with out website just give us a call or contact us by our E-mail. Become a member today and we will send you our news letter E-mail where you will be first to see our great offers, free gifts and special occasion alerts.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '7/13 Darul Sadar Janubi',
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              'Chenab Nagar (Rabwah)',
                              textAlign: TextAlign.justify,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    UrlLauncher.launch("tel://047 6213759");
                                  },
                                  child: Text(
                                    '047 6213759',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        letterSpacing: .3,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL();
                              },
                              child: Container(
                                width: double.infinity,
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'View Google Map',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ))
          ],
        ));
  }
}
