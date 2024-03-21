import 'package:chat_app/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/button.dart';
import '../component/text_field.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;

  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  //sign up for user
  void signUp() async {
    if (passwordController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password do not match!')
          )
      );
      return;
    }
    // get Auth Service

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
          emailController.text,
          passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  ///logo
                  Icon(
                    Icons.message,
                    size: 80,
                    color: Colors.grey[800],
                  ),

                  ///create account message
                  const Text(
                    'Let\'s create an account!',
                    style: TextStyle(fontSize: 16),
                  ),

                  ///email textfield
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: emailController,
                    obscureText: false,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///password textfield
                  MyTextField(
                    controller: passwordController,
                    obscureText: true,
                    hintText: 'password',
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /// Confirm password textfield
                  MyTextField(
                    controller: confirmPassController,
                    obscureText: true,
                    hintText: 'Confirm password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ///sign up button
                  MyButton(onTap: () {
                    signUp();
                  }, text: "Sign Up"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member?'),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
