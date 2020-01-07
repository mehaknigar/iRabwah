import 'package:flutter/material.dart';
import 'package:irabwah/Artboard.dart';
import 'package:irabwah/Drawer.dart';
import 'package:irabwah/directories/directoryMain.dart';
import 'package:irabwah/home.dart';
import 'package:irabwah/news.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}
class _BottomBarState extends State<BottomBar> {
  Future<bool> _onBackPressed(){
    return showDialog(
     context: context,
      builder: (context)=>AlertDialog(
        title: Text('Do you really want to exit the app?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: ()=>Navigator.pop(context,false),
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: ()=> Navigator.pop(context,true),
          ),
        ],
      )
    );
  }

 
  int currentIndex = 0;
  Widget callIndex(int index){
    switch (index){
    
    case 0:return Home();
    case 1:return News();
    case 2:return DirectoryMain();
    case 3:return Artboard();
    case 4:return DrawerPage();
    
    break;
    default: return Home();
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: Scaffold(
        body:callIndex(currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          onTap: (value){currentIndex=value;
            setState(() {
            });
          },
          items: [
           
             BottomNavigationBarItem( 
              icon:Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 26.2,
                ),
              title: Text('Home',style: TextStyle(color: Colors.white),),
            ),

            BottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage('images/NEWS.png'),
                  color: Colors.white,
                  size: 26.2,
                ),
                  title: Text('News',style: TextStyle(color: Colors.white),),
            ),

            BottomNavigationBarItem(
              icon: ImageIcon(
                    AssetImage('images/contactus.png'),
                    color: Colors.white,
                    size: 26.2,
                ),
                    title: Text('Directories',style: TextStyle(color: Colors.white),),
            ),
           
            BottomNavigationBarItem(
                  icon: ImageIcon(
                  AssetImage('images/stars.png'),
                  color: Colors.white,
                  size: 28.2,
                ),
                   title: Text('Media' ,style: TextStyle(color: Colors.white),),
            ),
              BottomNavigationBarItem( 
              icon:Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 26.2,
                ),
              title: Text('Drawer',style: TextStyle(color: Colors.white),),
            ),
            
            

          ],
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
        ),
      ),
    );
  }
}