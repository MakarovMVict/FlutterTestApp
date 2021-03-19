



import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Architecture/AbstractView.dart';
import 'package:flutter_app/MapBox/Camera.dart';
import 'package:flutter_app/MapBox/MapViewController.dart';
import 'package:flutter_app/MapBox/flutter_mapbox_view.dart';
import 'package:flutter_app/RouterUtils/ScreenArguments.dart';
import 'package:flutter_app/View/FloatingAppbarScreen.dart';
import 'package:flutter_app/View/ThirdScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../RouterUtils/Router.dart';
import 'DataFirstScreen.dart';
import 'SecondScreen.dart';
import 'package:rxdart/rxdart.dart';



void main() {
  runApp(MaterialApp(
    onGenerateRoute: (settings) {
      // If you push the PassArguments route
      if (settings.name == DataFirstScreenClass.routeName) {
        // Cast the arguments to the correct type: ScreenArguments.
        final TestScreenArguments args = settings.arguments;

        // Then, extract the required data from the arguments and
        // pass the data to the correct screen.
        return MaterialPageRoute(
          builder: (context) {
            return DataFirstScreenClass(
              title: args.title,
              message: args.message,
            );
          },
        );
      } else if (settings.name == FloatingAppBarScreen.routeName) {
        return MaterialPageRoute(
          builder: (context) {
            return FloatingAppBarScreen(

            );
          },
        );
      } else if (settings.name == ThirdScreenClass.routeName) {
        return MaterialPageRoute(
          builder: (context) {
            return ThirdScreenClass();
          },
        );
      }
      // The code only supports PassArgumentsScreen.routeName right now.
      // Other values need to be implemented if we add them. The assertion
      // here will help remind us of that higher up in the call stack, since
      // this assertion would otherwise fire somewhere in the framework.
      assert(false, 'Need to implement ${settings.name}');
      return null;
    },
    routes: {
      //MyApp.routeName: (context) => MyApp(),
    },
    home: MapboxExample()
  )
  );


}

// class MapLayout extends StatefulWidget{
//
//   @override
//   State<StatefulWidget> createState() {
//     //return MapLayoutState();
//     //throw UnimplementedError();
//   }
//
// }
// class MapLayoutState extends State<MapLayout>{
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//        child: MapboxExample(),
//     );
//     //throw UnimplementedError();
//   }
//
// }




class DraverMain extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Go to InfoScreen'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                DataFirstScreenClass.routeName,
                arguments: TestScreenArguments(
                  'InfoScreen',
                  'This message is extracted in the build method.',
                ),
              );
            },
          ),


          ListTile(
            title: Text('Go to FloatingAppBarScreen'),
            onTap: () {
              Navigator.pushNamed(context,FloatingAppBarScreen.routeName);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Go to Third Screen'),
            onTap: () {
              Navigator.pushNamed(context,ThirdScreenClass.routeName);
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
    throw UnimplementedError();
  }

}

/// test mapbox
class MapboxExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MapboxExampleState();
    throw UnimplementedError();
  }

}

class MapboxExampleState extends State<MapboxExample> {
  MapViewController controller;

  void _onMapViewCreated(MapViewController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter MapView example'),
      backgroundColor: Colors.green,),
      drawer: DraverMain(),

      body: Stack(children: [
        MapView(
          onMapViewCreated: _onMapViewCreated,
          // onMapViewCreated: _onMapViewCreated,
          // onTap: (point, coords) async {
          //   List ls = await controller.queryRenderedFeatures(point, ['LayerName'], null);
          //   print("queryRenderedFeatures test $ls");
          // },
        ),
        Column(
          children: [
            // RaisedButton(
            //   child: Text('Show User Location'),
            //   onPressed: () async {
            //     //check permissions before this, or turn them on manually.
            //     controller.showUserLocation();
            //   },
            // ),
            // RaisedButton(
            //   child: Text('getStyle'),
            //   onPressed: () async {
            //     print(await controller.getStyleUrl());
            //   },
            // ),
            // RaisedButton(
            //   child: Text('setStyle'),
            //   onPressed: () async {
            //     controller.setStyleUrl("mapbox://styles/mapbox/satellite-v9");
            //   },
            // ),
            // RaisedButton(
            //   child: Text('at ease'),
            //   onPressed: () async {
            //     // controller.easeTo(Camera(target: LatLng(lat: 32, lng: 35), zoom: 12), 2000);
            //     controller.easeTo(Camera(target: LatLng(lat: 32, lng: 35)), 2000);
            //   },
            // ),
            // RaisedButton(
            //   child: Text('fly to'),
            //   onPressed: () async {
            //     controller.flyTo(Camera(target: LatLng(lat: 32, lng: 35)),2000);
            //   },
            // ),
            // RaisedButton(
            //   child: Text('zoom only'),
            //   onPressed: () async {
            //     controller.zoom(10, 2000);
            //   },
            //),
          ],
        ),
      ]),
    );
  }
}




// RouterClass router=RouterClass();
//
//
//
// List <String> nameList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"];
// List <bool>mainList=List();
//
// //UI flags
// bool isTopVisible=true;
//
// void main() {
//   //runApp(MyApp());
//   ///RX testing simple
//   // var justObservable = Observable<int>.just(4242424242).where((event) => event==4242424242);
//   //
//   // justObservable.map((item) => item+=1 ).listen((item)=>{print("**item is listened!it is $item !")});
//  //  var subject = PublishSubject<String>();//.doOnError((error)=>print("item Error! $error")).doOnListen(() {print("onListen!");});
//  //
//  //  subject.
//  //  doOnError((error){print("*on error $error");}).
//  //  doOnDone(() {(){print("**on done!");};}).
//  //  doOnListen(() {print("**on listen!"); }).//onSubscribe
//  //  doOnEach((notification) {print("**on each! $notification"); }).//вызывается на любое действие,выводит сообщение с название метода и сводку об ошибках и тд
//  //  doOnCancel(() {print("**on cancell!"); }).
//  //      doOnData((event) {print("**on Data !$event");}).
//  //  listen((event) {print("*** ITEM LISTEN $event!");});
//  // // subject.listen((event) {print("*** ITEM LISTEN $event!");});
//  //  //subject.doOnCancel(() {print("**Cancel");});
//  // // subject.doOnEach((notification) {print("**notification! $notification");});
//  //  //.listen((item) => print(item))//.onError((){print("**item error!");});
//  //
//  //
//  //  subject.add("**Item1");
//  //  subject.add("**Item2");
//  //
//  //  //subject.listen((item) => print(item.toUpperCase()));
//  //
//  //  subject.add("**Item3");
//  //  subject.close();
//   // subject = PublishSubject<String>();
//   // subject.listen((item) => print(item.toUpperCase()));
//   //
//   // subject.add("**Item1");
//   // subject.add("**Item2");
//   //
//   // //subject.listen((item) => print(item.toUpperCase()));
//   //
//   // subject.add("**Item3");
//   // subject.close();
//
//
//
//
//   mainList=List.filled(nameList.length, false);
//
//
//   runApp(new MaterialApp(//
//     onGenerateRoute: (settings) {
//       // If you push the PassArguments route
//       if (settings.name == DataFirstScreenClass.routeName) {
//         // Cast the arguments to the correct type: ScreenArguments.
//         final TestScreenArguments args = settings.arguments;
//
//         // Then, extract the required data from the arguments and
//         // pass the data to the correct screen.
//         return MaterialPageRoute(
//           builder: (context) {
//             return DataFirstScreenClass(
//               title: args.title,
//               message: args.message,
//             );
//           },
//         );
//       }else if(settings.name == FloatingAppBarScreen.routeName){
//         return MaterialPageRoute(
//           builder: (context) {
//             return FloatingAppBarScreen(
//
//             );
//           },
//         );
//       }else if(settings.name == ThirdScreenClass.routeName){
//         return MaterialPageRoute(
//           builder: (context) {
//             return ThirdScreenClass();
//           },
//         );
//       }
//       // The code only supports PassArgumentsScreen.routeName right now.
//       // Other values need to be implemented if we add them. The assertion
//       // here will help remind us of that higher up in the call stack, since
//       // this assertion would otherwise fire somewhere in the framework.
//       assert(false, 'Need to implement ${settings.name}');
//       return null;
//     },
//     routes: {
//       MyApp.routeName: (context) => MyApp(),
//     },
//
//       home: scaffold,
//
//   )
//   );
//
// }
//
// void Function(int event) println(int e) {
//   print("**reactive print $e !");
// }
//
//
// ///скрывающаяся/открывающаяся панель
// class HiddingPanel extends StatefulWidget {
//   final String title;
//
//   HiddingPanel({Key key, this.title}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _HiddingPanelState();   // throw UnimplementedError();
//   }
//
//
// }
//
// class _HiddingPanelState extends State<HiddingPanel> {
//   // Whether the green box should be visible.
//   bool _visible = true;
//
//   @override
//   Widget build(BuildContext context) {
//     // The green box goes here with some other Widgets.
//     return Wrap(
//         children: <Widget>[
//
//
//             FadeInImage.assetNetwork(
//                 placeholder:'animations/spinner.gif' ,
//                 //image: 'https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png'),
//                 image:"https://upload.wikimedia.org/wikipedia/commons/5/5c/%D0%A3%D1%82%D1%80%D0%BE_%D0%B2_%D1%81%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D0%BE%D0%BC_%D0%BB%D0%B5%D1%81%D1%83_%28%D1%8D%D1%81%D0%BA%D0%B8%D0%B7%2C_%D0%A8%D0%B8%D1%88%D0%BA%D0%B8%D0%BD%29.jpg"),
//
//         ]);
//
//
//
//   }
// }
// ///скрывающаяся/открывающаяся панель
//
//
// Scaffold scaffold = Scaffold(
//     appBar: AppBar(
//         title: Text("My app"),
//     backgroundColor: Colors.green,),
//
//
//     drawer: DraverMain(),
//     // appBar: new AppBar(
//     //   title:Text("My app"),
//     //     leading: IconButton(
//     //       icon: Icon(Icons.chevron_left),
//     //       onPressed: (){/*()=>Navigator.pop(,false);*/},
//     //     ),
//     //   backgroundColor: Colors.green,),
//     body: MyApp()
//
// );
//
// class DraverMain extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text('Drawer Header'),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//             ),
//             ListTile(
//               title: Text('Go to InfoScreen'),
//               onTap: () {
//                 // Update the state of the app.
//                 // ...
//                 Navigator.pop(context);
//                 Navigator.pushNamed(
//     context,
//     DataFirstScreenClass.routeName,
//     arguments: TestScreenArguments(
//     'InfoScreen',
//     'This message is extracted in the build method.',
//     ),
//     );
//     },
//     ),
//
//
//             ListTile(
//               title: Text('Go to FloatingAppBarScreen'),
//               onTap: () {
//                 Navigator.pushNamed(context,FloatingAppBarScreen.routeName);
//                 // Update the state of the app.
//                 // ...
//               },
//             ),
//             ListTile(
//               title: Text('Go to Third Screen'),
//               onTap: () {
//                 Navigator.pushNamed(context,ThirdScreenClass.routeName);
//                 // Update the state of the app.
//                 // ...
//               },
//             ),
//           ],
//         ), // Populate the Drawer in the next step.
//     );
//     throw UnimplementedError();
//   }
//
// }
//
//
//
//
// class MyApp extends StatelessWidget{
//   static const routeName = '/MyApp';
//
//   @override
//   Widget build(BuildContext context) {
//
//     final MyApp args = ModalRoute.of(context).settings.arguments;
//
//
//     return MainScreen();
//       //torKey:router.rootNavigatorKey,
//
//     throw UnimplementedError();
//   }
//
// }
//
//
// class MainScreen extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return BaseColumn();
//     //throw UnimplementedError();
//   }
//
// }
//
// ///***********общая сетка экрана
// class BaseColumn extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return BaseColumnState();
//     throw UnimplementedError();
//   }
//
// }
//
// class BaseColumnState extends State<BaseColumn>{
//   bool isVisible=isTopVisible;
//   @override
//   Widget build(BuildContext context) {
//     return isVisible?Column(
//
//       children: [
//         HiddingPanel(),
//         ContainerTop(),
//         ListBottom()
//       ],
//     ):Column(
//
//       children: [
//
//         ContainerTop(),
//         ListBottom()
//       ],
//     );
//     throw UnimplementedError();
//   }
//
// }
//
//
//
// class ContainerTop extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return   ContainerState();
//     //throw UnimplementedError();
//   }
//
// }
//
// class ContainerState extends State<ContainerTop>{
//   bool _isPressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//    return SizedBox (child:
//      Container(
//       width: double.infinity,
//
//       color:Colors.yellow,
//        child: Center(
//
//          child: TextButton(child: _isPressed?Text("pressed!!!!"):Text("go to second screen "),
//            style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.red),
//            ),
//            onPressed: () {
//              setState(() {
//                _isPressed=!_isPressed;
//               // router.routeTo(RouteBundle(route: '/secondScreen', containerType: ContainerType.window));
//                Navigator.push(context, MaterialPageRoute(builder: (_) {
//                  return SecondScreenClass();
//                }));
//
//              });
//            },
//          ),
//        ),
//
//     )
//    );
//     //throw UnimplementedError();
//   }
//
// }
//
// class ListBottom extends StatefulWidget{
//
//   @override
//   State<StatefulWidget> createState() {
//
//     // TODO: implement createState
//     //throw UnimplementedError();
//     return ListState();
//   }
// }
//
// class ListState extends State<ListBottom>{
//
//   // List<String> list;
//   // List<bool> tappedList;
//   //
//   //
//   // ListState.data(this.list, this.tappedList);
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Expanded(
//         child:Container(
//             color: Colors.white38,
//             child:  ListView.builder(
//                 //separatorBuilder: (BuildContext context, int index) => Divider(),
//
//
//         //padding: const EdgeInsets.all(8),
//
//         itemCount: mainList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//
//             onTap: (){},
//             // child:
//             //Container(
//             //   decoration: BoxDecoration( //
//             //     color: Colors.white,//                    <-- BoxDecoration
//             //     border: Border(bottom: BorderSide()),
//             //   ),
//             //   height: 50,
//               //color: Colors.white,//Colors.amber[colorCodes[index]],
//               child: TappableContainerElement.typed(index,nameList[index])//Container(child: Text(list[index],)),//TODO set data for each container
//            // )
//           );
//         }
//     )
//         )
//     );
//
//   }
// }
//
// class TappableContainerElement extends StatefulWidget {
//
//   //bool isTapped=false;
//   int index;
//   String value;
//
//
//   TappableContainerElement.typed( this.index, this.value);
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//    // throw UnimplementedError();
//     return TappableElementState();
//   }
//
// }
//
// class TappableElementState extends State<TappableContainerElement> {
//   //Container container = Container()
//   //bool _isTapped=false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           setState(() {
//             //_isTapped=!_isTapped;
//             //widget.tappedList[]
//             mainList[widget.index] = !mainList[widget.index];
//           });
//         },
//         child: Container(
//           height: 50,
//           color: mainList[widget.index] ? Colors.amber : Colors.white12,
//           //Colors.amber[colorCodes[index]],
//           child: Center(
//               child: Text(widget.value)), //TODO set data for each container
//         )
//     );
//
//     //throw UnimplementedError();
//   }
//
// }
//
//
//
//
//
