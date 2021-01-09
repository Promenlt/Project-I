import 'package:hello_world/src/resources/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/src/blocs/auth_bloc.dart';
import 'dart:async';
class ChangePassPage extends StatefulWidget {
  @override
  _ChangePassPageState createState() => _ChangePassPageState();


}

class _ChangePassPageState extends State<ChangePassPage> {
  AuthBloc authBloc = new AuthBloc();
   TextEditingController _confirmPassController = TextEditingController();
   TextEditingController _passController = TextEditingController();
  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
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
                  "Hi Long Nguyen!",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              Text(
                "Change your password here!",
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 145, 0, 20),
                child: StreamBuilder(
                    stream: authBloc.passStream,
                    builder: (context, snapshot) => TextField(
                      controller: _passController,
                      obscureText: true,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          errorText:
                          snapshot.hasError ? snapshot.error : null,
                          labelText: "Password",
                          prefixIcon: Container(
                              width: 50, child: Image.asset("ic_lock.png")),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(6)))),
                    )),

              ),
              StreamBuilder(
                  stream: authBloc.confirmPassStream,
                  builder: (context, snapshot) => TextField(
                    controller: _confirmPassController,
                    obscureText: true,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        errorText:
                        snapshot.hasError ? snapshot.error : null,
                        labelText: "ConfirmPassword",
                        prefixIcon: Container(
                            width: 50, child: Image.asset("ic_lock.png")),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(6)))),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _onChangePassClick,
                    child: Text(
                      "Change password",
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

  void _onChangePassClick() {

    String confirmPass = _confirmPassController.text;
    String pass = _passController.text;
    var isPass= authBloc.checkPass(pass, confirmPass);
    if(confirmPass==pass){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()));
    }

  }
}