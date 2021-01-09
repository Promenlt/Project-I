import 'package:flutter/material.dart';
import 'package:hello_world/src/resources/home_page.dart';

class SuccessPage extends StatefulWidget{
  @override
  _SuccessPage  createState() => _SuccessPage();
  }
class _SuccessPage extends State<SuccessPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 140,
                ),
                Image.asset('ic_car_green.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                  child: Text(
                    "Thank you for drop car!",
                    style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 120, 0, 20),
                    child:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.black,size: 40.0,),
                        Icon(Icons.star, color: Colors.black,size: 40.0,),
                        Icon(Icons.star, color: Colors.black,size: 40.0,),
                        Icon(Icons.star, color: Colors.black,size: 40.0,),
                        Icon(Icons.star, color: Colors.black,size: 40.0,),
                      ],
                    ),
                ),
                Text(
                  "Rate us",
                  style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text(
                        "Back to Home Screen",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: Color(0xff3277D8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
  
}