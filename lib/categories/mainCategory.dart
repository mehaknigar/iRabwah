import 'package:flutter/material.dart';
import 'package:irabwah/categories/SubCatgories/electronics.dart';
import 'package:irabwah/categories/SubCatgories/food.dart';
import 'package:irabwah/categories/SubCatgories/occasion.dart';
import 'package:irabwah/categories/SubCatgories/ondemand.dart';
import 'package:irabwah/categories/combination.dart';
import 'package:irabwah/categories/featured.dart';
import 'package:irabwah/categories/gift.dart';
import 'package:irabwah/categories/kidsZone.dart';
import 'package:irabwah/categories/ring.dart';
import 'package:irabwah/categories/sport.dart';


class MainCategory extends StatefulWidget {
  @override
  _MainCategoryState createState() => _MainCategoryState();
}

class _MainCategoryState extends State<MainCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(backgroundColor: Colors.red,title: Text('Categories'),centerTitle: true,),
          
          body: Stack(fit: StackFit.expand, children: <Widget>[
              Image.asset("images/backround2.jpg",fit: BoxFit.fill,),
          
          SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[
                 
          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Featured (),),);},
          child: CardReuse('images/Featured.jpg', 'Featured')),

          GestureDetector( onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Occasion(),),);
            },child: CardReuse('images/Occasions.png', 'Occasions')),

          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Food1(),),);},
          child: CardReuse('images/Foods.png', 'Foods')),  
                  

          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Combination(),),);},
          child: CardReuse('images/Combination 2.png', 'Combinations')),
           GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Electronics(),),);},
          child: CardReuse('images/Electronics.png', 'Electronics')),

          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Demand(),),);},
          child: CardReuse('images/Order on Demand.png', 'Order on Demand')),
                    
          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Gift(),),);},
          child: CardReuse('images/Gifts.png', 'Gifts')),

          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => KidsZone(),),);},
          child: CardReuse('images/Kids Zone.png', 'Kids Zone')),

          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Rings(),),);},
          child: CardReuse('images/Alaisallah Rings.png', 'Alaisallah Rings')),

          GestureDetector(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>Sport(),),);},
          child: CardReuse('images/Sports 2.png', 'Sports')),

                  
                ],
              ),
            ),
          )
        ]
        ),
      

        );
  }
}

class CardReuse extends StatelessWidget {
final String image, text;
  CardReuse(this.image, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(height: 80,
      child: Card( elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
      child: Center(child: Row(children: <Widget>[SizedBox(width: 10,),
      CircleAvatar(radius: 30, backgroundImage: AssetImage(image),),
      SizedBox(width: 20,),
      Text(text,style: TextStyle(fontSize: 18.0, color: Colors.black87),),
        ]),
        )
        ,),
        );
  }
}

