library late_init;

import 'package:flutter/widgets.dart';

mixin LateInitMixin<T extends StatefulWidget> on State<T> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) {
      return;
    }

    _initialized = true;

    lateInitState();
  }

  void lateInitState();
}
