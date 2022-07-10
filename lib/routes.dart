import 'package:flutter/widgets.dart';
import 'package:cbms/profiles/profile.dart';

final Map<String, WidgetBuilder> routes = {
  profile.routeName: (context) => profile(),
};
