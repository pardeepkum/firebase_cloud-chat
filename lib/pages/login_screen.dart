import 'package:chat_app/component/button.dart';
import 'package:chat_app/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../component/text_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key,required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //user SignIn
  void signIn()async{
    //get the auth services
    final authService = Provider.of<AuthService>(context, listen:false);

    try{
      await authService.signInWithEmailandPassword(
          emailController.text,
          passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                ///logo
                Icon(
                  Icons.message,
                  size: 80,
                  color: Colors.grey[800],
                ),

                ///welcome back message
                const Text(
                  'Welcome back you\'ve are missed!',
                  style: TextStyle(fontSize: 16),
                ),

                ///email textfield
                const SizedBox(height: 20,),
                MyTextField(
                  controller: emailController,
                  obscureText: false,
                  hintText: 'Email',
                ),
                  const SizedBox(height: 10,),
                ///password textfield
                MyTextField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'password',
                ),
                const SizedBox(height: 20,),

                ///sign button
                MyButton(
                    onTap: (){
                      signIn();
                    },
                    text: "Sign in "),
                const SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Register Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    )
                  ],
                )
                /// not a register? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
