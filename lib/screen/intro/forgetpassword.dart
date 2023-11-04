import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/loginpage.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Make it perfect !',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: buttoncolor),
                ),
                const SizedBox(height: 30),
                Image.asset('assets/UI/image/template/pass.png', height: 200),
                const SizedBox(height: 100),
                const TextFieldBlue(
                  obscureText: true,
                  textcontent: 'Password',
                ),
                const SizedBox(height: 10),
                const TextFieldBlue(
                  obscureText: true,
                  textcontent: 'Confirm Password',
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: firstbutton(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Signup',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
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
