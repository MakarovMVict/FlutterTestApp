

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ViewModel/FloatingAppBarScreenVM.dart';

class FloatingAppBarScreen extends StatelessWidget{
  static const routeName = '/FloatingAppBarScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          // appBar:AppBar(title: Text("FloatingAppBarScreen"),
          // backgroundColor: Colors.green,) ,
          body: FloatingContainer());



    //throw UnimplementedError();
  }
}
class FloatingContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // Add the app bar and list of items as slivers in the next steps.
        slivers: <Widget>[
          SliverAppBar(    floating: true,
      // Display a placeholder widget to visualize the shrinking size.
      flexibleSpace: Placeholder(),
      // Make the initial height of the SliverAppBar larger than normal.
      expandedHeight: 200,
    ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
                  (context, index) => Expanded(child:Container(
                    width: 100,
                    height:100,
                    color: Colors.white,
                    child:FadeInImage.assetNetwork(
                        placeholder:'animations/spinner.gif' ,
                        image: 'http://oboi-dlja-stola.ru/file/984/760x0/16:9/%D0%A3%D1%82%D1%80%D0%BE-%D0%B2-%D1%81%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D0%BE%D0%BC-%D0%BB%D0%B5%D1%81%D1%83.jpg'),
                  )
                  ),
              // Builds 1000 ListTiles
              childCount: 20,
            ),
          )


        ]
    );

  //    throw UnimplementedError();
  }

}
// Container(
// width: double.infinity,
// height:double.infinity,
// color: Colors.white,
// child:FadeInImage.assetNetwork(
// placeholder:'animations/spinner.gif' ,
// image: 'http://oboi-dlja-stola.ru/file/984/760x0/16:9/%D0%A3%D1%82%D1%80%D0%BE-%D0%B2-%D1%81%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D0%BE%D0%BC-%D0%BB%D0%B5%D1%81%D1%83.jpg'),
// );