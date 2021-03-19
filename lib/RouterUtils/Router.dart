import 'package:flutter/cupertino.dart';
import 'package:flutter_app/View/SecondScreen.dart';

import 'IRouter.dart';


///***
///This example from https://habr.com/ru/post/512072/
///***

class RouterClass implements IRouter {
  @override
  GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  // @override
  // Future<T> routeTo<T>(RouteBundle bundle) async {
  //   // Push logic here
  // }

  @override
  Future<bool> back<T>({T data, bool rootNavigator = false}) async {
    NavigatorState rootState = rootNavigatorKey.currentState;
    return await (rootState).maybePop<T>(data);
  }

  @override
  Future<T> routeTo<T extends Object>(bundle) async {
    assert(bundle != null, "The bundle [RouteBundle.bundle] is null");
    NavigatorState rootState = rootNavigatorKey.currentState;
    assert(rootState != null, 'rootState [NavigatorState] is null');

    switch (bundle.route) {
      case "/secondScreen":
        return await rootState.push(
          _buildRoute<T>(
            bundle: bundle,
            child: SecondScreenClass(),
          ),
        );

      default:
        throw Exception('Route is not found');
    }
    //throw UnimplementedError();
  }


  Route<T> _buildRoute<T>({@required RouteBundle bundle, @required Widget child}) {
    assert(bundle.containerType != null, "The bundle.containerType [RouteBundle.containerType] is null");

    switch (bundle.containerType) {
      case ContainerType.scaffold:
        return CupertinoPageRoute<T>(
          title: bundle.title,
          builder: (BuildContext context) => child,
          settings: RouteSettings(name: bundle.route),
        );

      case ContainerType.window:
        return CupertinoPageRoute<T>(
          settings: RouteSettings(name: bundle.route),
          builder: (BuildContext context) => child,
        );
      default:
        throw Exception('ContainerType is not found');
    }
  }

}

enum ContainerType {
  /// The parent type is [Scaffold].
  ///
  /// In IOS route with an iOS transition [CupertinoPageRoute].
  /// In Android route with an Android transition [MaterialPageRoute].
  ///
  scaffold,

  /// Used for show child in dialog.
  ///
  /// Route with [DialogRoute].
  dialog,

  /// Used for show child in [BottomSheet].
  ///
  /// Route with [ModalBottomSheetRoute].
  bottomSheet,

  /// Used for show child only.
  /// [AppBar] and other features is not implemented.
  window,
}
class RouteBundle {
  /// Creates a bundle that can be used for [RouterClass].
  RouteBundle({
    this.route,
    this.containerType,
    this.title
  });

  /// The route for current navigation.
  ///
  /// See [Routes] for details.
  final String route;
  String title;

  /// The current status of this animation.
  final ContainerType containerType;
}