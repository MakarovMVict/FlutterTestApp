import 'package:flutter/cupertino.dart';

import 'Router.dart';

abstract class IRouter {
  Future<T> routeTo<T extends Object>(RouteBundle bundle);
  Future<bool> back<T extends Object>({T data, bool rootNavigator});
  GlobalKey<NavigatorState> rootNavigatorKey;
}