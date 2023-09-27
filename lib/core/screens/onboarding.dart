import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/models/todo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';
import 'package:todo_app/core/screens/add_todo_page.dart';
import 'package:todo_app/core/screens/homepage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/img_giriş.png'),
              Text('Welcome to ToDo app',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize)),
              // Text('Todos Number: ${todos.length}',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize:
              //             Theme.of(context).textTheme.titleLarge!.fontSize)),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (context) => HomePage(),
              //       ));
              //     },
              //     child: Text('Start to use app'))
            ],
          ),
        ),
      ),
    );
  }
}
