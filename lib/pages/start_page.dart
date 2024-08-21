import 'package:flutter/material.dart';
import 'package:weeklyfinancetracker/pages/home_page.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 175, 162),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

             const Image(
              image: AssetImage('lib/images/logo.png'),
              width: 350,
             height: 350,
              ),







          // sign in button
          MaterialButton(
          minWidth: 150,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
                ),
              );
          },
            color: Color.fromARGB(255, 100, 68, 13),
            textColor: Colors.white,
            child: const Text('ENTER'),
            ),
             
             
        
            const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}
