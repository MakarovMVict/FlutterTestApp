

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ViewModel/TestScreenViewModel.dart';
///
/// для виджета-обёртки в любом окне
///
class AbstractView extends StatefulWidget /*with AbstractVM<TestScreenViewModel>*/{
  var customVidget;

  AbstractView(this.customVidget);



  @override
  State<StatefulWidget> createState() {
    print("**AV create state!!!");
    return AbstractViewState();

  }
}

class AbstractViewState extends State<AbstractView>{
  // var widget;



  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
      leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context,
            "default result of pop"),),
    ),
        body: SingleChildScrollView(child:this.widget.customVidget,)


    );


  }

}