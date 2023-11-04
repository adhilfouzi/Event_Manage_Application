import 'package:flutter/material.dart';
import 'package:project_event/screen/intro/loginpage.dart';
import 'package:project_event/screen/intro/signup_page.dart';

class Entry extends StatelessWidget {
  const Entry({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/UI/image/entry.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text at the top center
          Column(
            // Use Column instead of Expanded
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 110, 16, 16),
                  child: Text(
                    'Event Time',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Buttons at the bottom center
          Column(
            // Use Column instead of Expanded
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(25, 580, 25, 50),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Life is only once, Enjoy your life!',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: withr,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text('Signup',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: withr,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

ButtonStyle withr = ButtonStyle(
  padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
  side: MaterialStateProperty.all(
      const BorderSide(color: Colors.white, width: 1.5)),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  )),
);
