import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateData extends StatefulWidget {
  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  bool loggedInPresent = false, loggedIn = false;
  SharedPreferences sharedPreferences;
  final TextEditingController shippingAddress = TextEditingController();
  final TextEditingController city = TextEditingController();
  @override
  void initState() {
    super.initState();
    ini();
  }

  final key = GlobalKey<FormState>();
  void ini() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      loggedInPresent = sharedPreferences.containsKey('LoggedIn');
      if (loggedInPresent) {
        loggedIn = sharedPreferences.getBool('LoggedIn');
      }
    });
  }

  updateShippingAddress(String id) async {
    if (shippingAddress.text != '' && city.text != '') {
      await sharedPreferences.setString(
          'address_2', shippingAddress.text.toString());
      await sharedPreferences.setString('city', city.text.toString());

      http.Response response = await http.get(
          "http://app.irabwah.com/app_data/Sign/update.php?shippingAddress=${shippingAddress.text}&id=$id&city=${city.text}");

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Detail'),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Image.asset(
            "images/Contact.jpg",
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Form(
              key: key,
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 70, 25, 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        offset: Offset(5, 5),
                        blurRadius: 10.0,
                      )
                    ]),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 14.0),
                    TextFormField(
                      controller: shippingAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Your Address";
                        }
                        return null;
                      },
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        contentPadding: const EdgeInsets.all(
                          16.0,
                        ),
                        prefixIcon: Material(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.home,
                            color: Colors.red,
                          ),
                        ),
                        hintText: "Shipping Address",
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: city,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        contentPadding: const EdgeInsets.all(
                          16.0,
                        ),
                        prefixIcon: Material(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.location_city,
                            color: Colors.red,
                          ),
                        ),
                        hintText: " City ",
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(),
                      child: RaisedButton(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                        highlightElevation: 0,
                        textColor: Colors.white,
                        color: Colors.red,
                        onPressed: () => {
                          setState(() {
                            if (key.currentState.validate()) {
                              updateShippingAddress(sharedPreferences
                                  .getString('customer_id')
                                  .toString());
                            }
                          }),
                        },
                        child: Text("Update"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
