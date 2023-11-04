import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/forgetpassword.dart';
import 'package:project_event/screen/intro/signup_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 60),
              Container(
                height: 30,
                child: const Text(
                  'Welcome Back !',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: buttoncolor),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/UI/image/template/login.png', height: 200),
              const SizedBox(height: 50),
              Container(
                height: 500,
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.bottomCenter,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const TextFieldBlue(
                        textcontent: 'Email',
                        keyType: TextInputType.emailAddress),
                    const SizedBox(height: 5),
                    const TextFieldBlue(
                        obscureText: true,
                        textcontent: 'Password',
                        keyType: TextInputType.emailAddress),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ForgetPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forget your password ?',
                          style: TextStyle(color: buttoncolor),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: firstbutton(),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                            child: const Text('Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('If you are new here',
                        style: TextStyle(color: buttoncolor)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: secbutton(),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text('Signup',
                                style: TextStyle(
                                    color: buttoncolor, fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ButtonStyle firstbutton() {
  return ButtonStyle(
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor),
  );
}

ButtonStyle secbutton() {
  return ButtonStyle(
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );
}
