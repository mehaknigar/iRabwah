import 'package:flutter/material.dart';
import 'package:irabwah/Sign_in_up/preference.dart';
import 'package:irabwah/Sign_in_up/userModel.dart';
import 'package:irabwah/User/chat.dart';
import 'package:irabwah/User/myOrder.dart';
import 'package:irabwah/bottom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;
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
      }
    });
  }

  void logout() async {
    sharedPreferences = await PreferenceManager.removeDetails();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Theme(
          data: ThemeData(
            primaryColor: Colors.red,
            appBarTheme: AppBarTheme(
              color: Colors.red,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
          ),
          child: Scaffold(
            backgroundColor: Theme.of(context).buttonColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Profile'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    logout();
                  },
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("You"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("My Orders"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Message"),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              Stack(fit: StackFit.expand, children: <Widget>[
                Image.asset(
                  "images/backround2.jpg",
                  fit: BoxFit.fill,
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4),
                        ),
                        Container(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Row(children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    backgroundImage:AssetImage('images/user.png'),
                                    // NetworkImage(
                                       // 'https://cdn.shopify.com/s/files/1/0175/3330/4886/files/salt-products-application_e7c84b86-bd49-42bc-bb3b-c2b88ec36a53_670x.png?v=1570737752'),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Username: ${sharedPreferences.getString('firstname'.toString())}\ ${sharedPreferences.getString('lastname'.toString())}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            "Account Information",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.red,
                                        thickness: 2,
                                      ),
                                      Container(
                                          child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.people),
                                            title: Text("Name"),
                                            subtitle: Text(
                                                "${sharedPreferences.getString('firstname'.toString())}\ ${sharedPreferences.getString('lastname'.toString())}"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.email),
                                            title: Text("Email"),
                                            subtitle: Text(sharedPreferences
                                                .getString('email'.toString())),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: Text("Phone"),
                                            subtitle: Text(
                                                sharedPreferences.getString(
                                                    'telephone'.toString())),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.location_city),
                                            title: Text("Address"),
                                            subtitle: Text(sharedPreferences
                                                .getString('address_1')
                                                .toString()),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.location_city),
                                            title: Text("Shipping Address"),
                                            subtitle: Text(sharedPreferences
                                                .getString('address_2')
                                                .toString()),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              Container(
                  child: MyOrders(
                      sharedPreferences.getString('customer_id').toString())),
              Container(
                child: Chat(sharedPreferences.getString('email').toString()),
              ),
            ]),
          ),
        ));
  }
}
