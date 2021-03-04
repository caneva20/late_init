import 'package:flutter/material.dart';
import 'package:late_init/late_init.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Late Init - Example',
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with LateInitMixin {
  @override
  void lateInitState() {
    final someId = ModalRoute.of(context)!.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(color: Colors.red),
    );
  }
}
