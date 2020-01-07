import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:irabwah/Sign_in_up/preference.dart';
import 'package:irabwah/Sign_in_up/sing_up.dart';
import 'package:irabwah/Sign_in_up/userModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sweetalert/sweetalert.dart';
import 'connection.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

@override
class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  bool _isInAsyncCall = false;
  void initState() {
    super.initState();
    PreferenceManager.getDetails().then((user) {
      if (user != null && user.email != null && user.password != null) {
        makeHttpRequest(user.email, user.password);
      }
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    setState(() {
      _isInAsyncCall = true;
    });
    String email = emailController.text;
    String password = passwordController.text;
    makeHttpRequest(email, password);
  }

  void makeHttpRequest(String email, String password) async {
    http.Response response = await http.get(
     "http://192.168.10.7/irabwah/Sign/signin.php?email=${emailController.text}&password=${passwordController.text}",
   //   "http://app.irabwah.com/app_data/Sign/signin.php?email=${emailController.text}&password=${passwordController.text}",
    );

    Map<String, dynamic> map = jsonDecode(response.body);

    if (map['statusCode'] == 200 && map['statusMessage'] == 'AuthorizedUser') {
      Map<String, dynamic> userDetails = map["userDetails"];
      User user = User(
        userDetails['customer_id'].toString(),
        userDetails['telephone'].toString(),
        userDetails['firstname'].toString(),
        userDetails['lastname'].toString(),
        userDetails['email'].toString(),
        userDetails['password'].toString(),
        userDetails['address_1'].toString(),
        userDetails['address_2'].toString(),
        userDetails['city'].toString(),
      );

      PreferenceManager.saveDetails(user);
      print(userDetails);
      Navigator.pop(context);
      setState(() {
        _isInAsyncCall = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Note : Invalid User'),
          content: Text("Try Again.."),
        ),
      );
      setState(() {
        _isInAsyncCall = false;
      });
    }
  }
    void submitData() {
    checkConn().then((internet) {
      if (internet != null && internet) {
        login();
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

  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.red)),
      child: Stack(children: <Widget>[
        FractionallySizedBox(
          heightFactor: 0.6,
          child: Container(
            color: Colors.red,
          ),
        ),
        const SizedBox(height: kToolbarHeight - 16.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.topCenter,
            height: (MediaQuery.of(context).size.height / 2) - 140,
            child: Image.asset(
              'images/Sign.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight - 16.0),
        SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(25, 220, 25, 16),
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
                    controller: emailController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Required";
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
                          Icons.email,
                          color: Colors.red,
                        ),
                      ),
                      hintText: "Enter your email ",
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    cursorColor: Colors.red,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your password",
                      contentPadding: const EdgeInsets.all(
                        16.0,
                      ),
                      prefixIcon: Material(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.lock,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
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
                          if (formKey.currentState.validate()) {
                            submitData();
                          }
                        }),
                      },
                      child: Text("Sign In"),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(),
                    child: RaisedButton(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Colors.red,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      ),
                      child: Text("Sign Up"),
                    ),
                  ),
                ],
              ),
            ),
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ]),
      inAsyncCall: _isInAsyncCall,
    ));
  }
}
