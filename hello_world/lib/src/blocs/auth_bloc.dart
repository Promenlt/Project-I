import 'dart:async';

import 'package:hello_world/src/fire_base/fire_base_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();

  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _confirmPassController =new StreamController();
  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get confirmPassStream =>_confirmPassController.stream;

  bool checkPass(String pass, String confirmPass){
    if(pass==null){
      _passController.sink.addError("Nhập mật khẩu");
      return false;
    }
    _passController.sink.add("");
    if(confirmPass==null){
      _confirmPassController.sink.addError("Nhập lại mật khẩu");
      return false;
    }
    _confirmPassController.sink.add("");
    if(pass!=confirmPass){
      _passController.sink.addError("Khác mật khẩu");
      return false;
    }
    _confirmPassController.sink.add("");
  }
  bool isValid(String name, String email, String pass, String phone) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError("Nhập tên");
      return false;
    }
    _nameController.sink.add("");

    if (phone == null || phone.length == 0 ) {
      _phoneController.sink.addError("Nhập số điện thoại");
      return false;
    }
    if (phone.length != 10||phone[0]!='0') {
      _phoneController.sink.addError("Số điện thoại phải bao gồm 10 kí tự số và bắt đầu bởi 0");
      return false;
    }
    _phoneController.sink.add("");

    if (email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(emailValid==false){
      _emailController.sink.addError("Email phải có định dạng example@abc.xyz");
      return false;
    }
    _emailController.sink.add("");

    if (pass == null || pass.length < 6) {
      _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(email, pass, name, phone, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}