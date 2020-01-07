import 'package:flutter/material.dart';
import 'package:irabwah/directories/parlor.dart';
import 'package:irabwah/directories/rent.dart';
import 'package:irabwah/directories/restaurants.dart';
import 'bakers.dart';
import 'bank.dart';
import 'courier.dart';
import 'currencyExchange.dart';
import 'jewellers.dart';
import 'marriageHall.dart';

class DirectoryMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "images/backround2.jpg",
            fit: BoxFit.fill,
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/Logo.png",
                      width: 250,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Rabwah Directory',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35,),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Parlor(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer 11.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Bank(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer2.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Courier(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer311.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Currency(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer32.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Jewellers(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer33.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Marriage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer34.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Restaurants(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer35.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Rent(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer36.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Bakers(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/Layer37.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
