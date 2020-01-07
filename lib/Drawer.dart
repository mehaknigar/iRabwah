import 'package:flutter/material.dart';
import 'package:irabwah/Pages/Letter.dart';
import 'package:irabwah/Pages/aboutUs.dart';
import 'package:irabwah/Cart/cart.dart';
import 'package:irabwah/Pages/contactUs.dart';
import 'package:irabwah/Pages/impNumbers.dart';
import 'package:irabwah/Pages/kidStory.dart';
import 'package:irabwah/Pages/rabwahHistory.dart';
import 'package:irabwah/Sign_in_up/sign_in.dart';
import 'package:irabwah/User/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool loggedInPresent = false, loggedIn = false;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    ini();
  }

  void ini() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      loggedInPresent = sharedPreferences.containsKey('LoggedIn');
      if (loggedInPresent) {
        loggedIn = sharedPreferences.getBool('LoggedIn');
        print(sharedPreferences.getString('firstname'));
      }
    });
  }

  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      DrawerHeader(
        child: Image.asset("images/Logo.png"),
      ),
      Divider(
        height: 5,
        thickness: 3,
        color: Colors.red,
      ),
      ListTile(
          leading: Icon(Icons.person, color: Colors.red),
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            if (sharedPreferences.getString('firstname').toString() != "null") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              );
            }
          }),
      Divider(
        height: 5,
      ),
      ListTile(
          leading: Icon(Icons.history, color: Colors.red),
          title: Text(
            'Rabwah History',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => History(),
              ),
            );
          }),
      Divider(
        height: 5,
      ),
      ListTile(
          leading: Icon(Icons.note, color: Colors.red),
          title: Text(
            'News Letter',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Letter(),
              ),
            );
          }),
      Divider(
        height: 5,
      ),
      ListTile(
          leading: Icon(Icons.phone, color: Colors.red),
          title: Text(
            'Important Numbers',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Numbers(),
              ),
            );
          }),
      Divider(
        height: 5,
      ),
      ListTile(
          leading: Icon(Icons.tag_faces, color: Colors.red),
          title: Text(
            'Kids Zone',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KidsStory(),
              ),
            );
          }),
      Divider(
        height: 5,
      ),
      ListTile(
          leading: Icon(Icons.add_shopping_cart, color: Colors.red),
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCart(),
              ),
            );
          }),
      Divider(
        height: 5,
      ),
      ListTile(
          leading: Icon(Icons.contacts, color: Colors.red),
          title: Text(
            'Contact Us',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactUs(),
              ),
            );
          }),
      Divider(
        height: 5,
      ),
      ListTile(
          leading: Icon(Icons.info, color: Colors.red),
          title: Text(
            'About Us',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutUs(),
              ),
            );
          }),
      Divider(
        height: 5,
      ),
    ]);
  }
}
