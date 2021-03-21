# late_init

Execute code at a later stage, but before build has been called for the first time. Useful for initializations that depends on the context

*This package was inspired by [after_layout](https://pub.dev/packages/after_layout)

## Quick Usage

Given a **statefull** widget:

```dart
class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    //TODO: implement build method
  }
}
```

Add `with LateInitMixin<MyWidget>` mixin to your `State<MyWidget>` class and then implement the `void lateInitState()` method.

```dart
class MyWidgetState extends State<MyWidget> /*HERE. Add this bit -->*/ with LateInitMixin<MyWidget> {
  //Code in this method will be called once at a later stage where [context]
  //can be used for actions such as `ModalRoute.of(context)`, `Provider.of<>(context)`
  @override
  void lateInitState() {
    final someId = ModalRoute.of(context).settings.arguments as String;
  }
  
  // The rest of the widget...
}
```

## Complete example

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

class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> with LateInitMixin<MyWidget> {
  @override
  void lateInitState() {
    final someId = ModalRoute.of(context)!.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.red),
    );
  }
}
```

## What not to do with this package
If you're trying to get the size, position or something that depends on the layout of the widget, using lateInitState **WILL NOT DO**, for that kind of information the widget needs to be rendered at least once before you can get that info, if that's what you're trying to do, then take a look at [after_layout](https://pub.dev/packages/after_layout) which is a package similar to this, but to run code after the first layout.
