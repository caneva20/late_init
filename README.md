# late_init

Execute code at a later stage, but before build has been called for the first time. Useful for initializations that depends on the context

## Quick Usage

Add with LateInitMixin<MyWidget> mixin to your State<MyWidget> class and then implement the void lateInitState() abstract method. Code in this method will be called once at a later stage where context can be used for actions such as `ModalRoute.of(context)`, `Provider.of<>(context)`

## Motivation
If you want to display a widget that depends on the context (such as ModalRoute or [Provider](https://pub.dev/packages/provider) ), you can not use that in `initState`.

## Usage

This demo showcases how this package resolves the shortcomings shown above:

**GOOD CODE**

```dart
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
    final someId = ModalRoute.of(context).settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Container(color: Colors.red));
  }
}
```