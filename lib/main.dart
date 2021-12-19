import 'dart:html';

import 'package:provider/provider.dart';
import 'package:statemanagement/buissenes_logic.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
          create: (_) => Logic(), child: const MaterialApp(home: LoginPage()));
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Login page build() is run');
    Logic currentState = Provider.of<Logic>(context);
    if (currentState.currentUser != null) {
      return const HomePage();
    }
    return const Center(
        child: CircularProgressIndicator());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('state management example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [LowLevelWidget(),SizedBox(height: 50,),LowLevelButton()],
        ),
      ),
    );
  }
}

class LowLevelWidget extends StatelessWidget {
  const LowLevelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('low level widget is run');
    return SizedBox(
      child: Text(Provider.of<Logic>(context).lowLevelState ?? "name"),
    );
  }
}

class LowLevelButton extends StatelessWidget {
  const LowLevelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('low level button is run');
    return TextButton(onPressed: () {
      Provider.of<Logic>(context,listen: false).setLowLevelState();
    },
    child: const Text('click'),
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    ),);
  }
}
