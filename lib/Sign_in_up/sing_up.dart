import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sweetalert/sweetalert.dart';

import 'connection.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  void initState() {
    super.initState();

    this.fetchStates();
  }

  bool _isInAsyncCall = false;
  List state = List();
  Future<String> fetchStates() async {
    var res = await http.get(
      Uri.encodeFull('http://192.168.10.7/irabwah/Sign/country.php'),
      //  Uri.encodeFull('http://app.irabwah.com/app_data/Sign/country.php'),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      state = resBody;
    });

    return "Success";
  }

  String bCountry;

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void addData(Map<String, dynamic> body) async {
    setState(() {
      _isInAsyncCall = true;
    });
    var url = "http://192.168.10.7/irabwah/Sign/registration.php";
   // var url = "http://app.irabwah.com/app_data/Sign/registration.php";
    var response = await http.post(url, body: jsonEncode(body));
    var message = json.decode(response.body);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Alert Dialog",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green),
        ),
        content: Text(
          message,
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        actions: [
          FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                if (message == 'Registered Successfully.Please Login') {
                  Navigator.pop(context);
                }
              })
        ],
      ),
    );
    setState(() {
      _isInAsyncCall = false;
    });
    print(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Register'),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        opacity: 0.5,
        inAsyncCall: _isInAsyncCall,
        progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red)),
        child: Stack(
          children: <Widget>[
            Image.asset(
              "images/backround2.jpg",
              fit: BoxFit.fill,
            ),
            FractionallySizedBox(
              heightFactor: 0.4,
              child: Container(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: kToolbarHeight - 16.0),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 50, 25, 16),
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
                      const SizedBox(height: 16.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['firstname'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Name Required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.person,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "First",
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['lastname'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Name Required";
                          }
                          return null;
                        },
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.person,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "Last",
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['email'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty ||
                              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.email,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "Email ",
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['telephone'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Telephone Required";
                          }
                          return null;
                        },
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "Telephone ",
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['address_1'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Address Required";
                          }
                          return null;
                        },
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.home,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "Address",
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      DropdownButtonFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Select Country';
                          }
                          return null;
                        },
                        items: state.map(
                          (item) {
                            return new DropdownMenuItem(
                              value: item['name'].toString(),
                              child: Row(
                                children: <Widget>[
                                  Text(item['name']),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          _formData['country_id'] = value;
                          setState(() {
                            bCountry = value;
                          });
                        },
                        value: bCountry,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.my_location,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "Country",
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['city'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "City Required";
                          }
                          return null;
                        },
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.location_city,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "City ",
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['postcode'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "PostCode Required";
                          }
                          return null;
                        },
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.location_searching,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "Post Code ",
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        onChanged: (value) {
                          _formData['password'] = value;
                        },
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Password Required";
                          }
                          return null;
                        },
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Material(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          hintText: "Password",
                        ),
                      ),
                      const SizedBox(height: 12.0),
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
                          onPressed: ()  {
                            setState(() {
                              if (formKey.currentState.validate()) {
                              
    checkConn().then((internet) {
      if (internet != null && internet) {
         addData(_formData);
      } else {
        SweetAlert.show(
          context,
          title: "Connection Error",
          subtitle: "Please Connect to the Internet.",
          style: SweetAlertStyle.error,
        );
      }
    });
  
                               
                              }
                            });
                          },
                          child: Text("Register"),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
