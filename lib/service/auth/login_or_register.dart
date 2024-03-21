import 'package:chat_app/pages/login_screen.dart';
import 'package:chat_app/pages/register_screeen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show the login Screen
    bool showLoginPage = true;

    //toggle between login and register page
void togglePress(){
  setState(() {
    showLoginPage = !showLoginPage;
  });
}
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return  LoginScreen(onTap: togglePress);
    }else{
      return RegisterScreen(onTap: togglePress);
    }
  }
}
