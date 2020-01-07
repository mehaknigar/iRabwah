import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  Future sendMail() async {
    if ((EmailValidator.validate(emailController.text)) == true) {
      final response = await http.post(
          "http://app.irabwah.com/app_data/ContactUs/contactUs.php",
          body: <String, dynamic>{
            'name': nameController.text,
            'email': emailController.text,
            'message': msgController.text
          });
      SweetAlert.show(
        context,
        subtitle: "Your mail is sent",
        style: SweetAlertStyle.success,
      );
      nameController.text = '';
      emailController.text = '';
      msgController.text = '';
    } else {
      SweetAlert.show(
        context,
        subtitle: "Email invalid",
        style: SweetAlertStyle.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Image.asset(
            "images/Contact.jpg",
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 90, 25, 16),
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
                      controller: nameController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Your Name";
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
                            Icons.person,
                            color: Colors.red,
                          ),
                        ),
                        hintText: " Name ",
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                     
                      controller: emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Your Email";
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
                        hintText: " Email ",
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                       
                      controller: msgController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Your Message...";
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
                        
                        hintText: " Message ",
                       
                      ),
                      
                       maxLines: 3,
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
                              sendMail();
                            }
                          }),
                        },
                        child: Text("Submit"),
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
