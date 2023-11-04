import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/loginpage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Let’s Begin the game',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: buttoncolor),
                ),
                const SizedBox(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const TextFieldBlue(
                        textcontent: 'Full Name', keyType: TextInputType.name),
                    const SizedBox(height: 10),
                    const TextFieldBlue(
                        textcontent: 'Email',
                        keyType: TextInputType.emailAddress),
                    const SizedBox(height: 10),
                    const TextFieldBlue(
                        textcontent: 'Phone Number',
                        keyType: TextInputType.number),
                    const SizedBox(height: 10),
                    const TextFieldBlue(
                      obscureText: true,
                      textcontent: 'Password',
                    ),
                    const SizedBox(height: 10),
                    const TextFieldBlue(
                      obscureText: true,
                      textcontent: 'Confirm Password',
                    ),
                    //const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: checkboxValue,
                          onChanged: (bool? value) {
                            setState(() {
                              checkboxValue = value!;
                            });
                          },
                        ),
                        const Text(
                          'I agree with Terms and Privacy ',
                          style: TextStyle(color: buttoncolor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: firstbutton(),
                            onPressed: () {
                              if (checkboxValue == true) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              } else {
                                return;
                              }
                            },
                            child: const Text('Signup',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account -',
                            style: TextStyle(color: buttoncolor)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Login',
                              style: TextStyle(color: buttoncolor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
