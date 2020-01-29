# late_init

Execute code at a later stage, but before build has been called for the first time. Useful for initializations that depends on the context

*This package was inspired by [after_layout](https://pub.dev/packages/after_layout)

## Quick Usage

Add with LateInitMixin<MyWidget> mixin to your State<MyWidget> class and then implement the void lateInitState() abstract method. Code in this method will be called once at a later stage where context can be used for actions such as `ModalRoute.of(context)`, `Provider.of<>(context)`

## Usage

This demo showcases how this package resolves the shortcomings shown above:

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

## What not to do with this package
If you're trying to get the size, position or something that depends on the layout of the widget, using lateInitState WILL NOT DO, for that kind of information the widget needs to be rendered at least once before you can get that info, if that's what you're trying to do take a loot at [after_layout](https://pub.dev/packages/after_layout) which is package similar to this but to run code after the first layout