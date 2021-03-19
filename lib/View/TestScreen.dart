import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Architecture/AbstractView.dart';
import 'package:flutter_app/ViewModel/TestScreenViewModel.dart';






TextEditingController controller;


class TestScreenClass extends StatelessWidget {
  TestScreenViewModel testScreenViewModel=TestScreenViewModel();



  @override
  Widget build(BuildContext context) {
    controller=TextEditingController();
    //getViewModel();


    return AbstractView(body);
  }





Widget body = Column(
    mainAxisSize: MainAxisSize.min,
    children:[
      Flexible(
          flex: 1,
          //  fit: FlexFit.loose,
          child:Container(
            width: double.infinity,
            height:300,
              color: Colors.yellow,
              child:  Text("")
          )),
      Flexible(
          flex: 2,

          fit: FlexFit.loose,
          child:StreamBuilder( builder: (context, snapshot) {
            return MyTextField(
                controller,
                "Email",
                snapshot.data);
          }
      )),
      Flexible(
          flex: 10,
          fit: FlexFit.loose,
          child: Container(
            //width: double.infinity,
            // height:double.infinity,
            color: Colors.teal,
            child: Text(""),
          ))
    ]
);

}

class MyTextField extends StatefulWidget{

  TextEditingController textEditingController;
  String hintText;
  String errorText;

  MyTextField(this.textEditingController, this.hintText, this.errorText);


  @override
  State<StatefulWidget> createState() {
    // controller.addListener(() => _viewModel.inputMailText.add(controller.text));
    return MyTextFieldState(controller,"enter email here!","enter valid email!");
    //throw UnimplementedError();
  }

}

class MyTextFieldState extends State<MyTextField> with WidgetsBindingObserver{
  TextEditingController textEditingController;
  String hintText;
  String errorText;

  MyTextFieldState(this.textEditingController, this.hintText, this.errorText);

  @override
  void initState() {
    super.initState();
    //  WidgetsBinding.instance.addObserver(this);
  }



  @override
  void didChangeMetrics() {
    // final value = WidgetsBinding.instance.window.viewInsets.bottom;
    // bool isVisible = value > 0;
    //  print("**KEYBOARD VISIBLE: ${isVisible}");
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      //flex: 1,
        child:TextFormField(
          controller: textEditingController,
          cursorColor: Colors.red,
          //autofillHints: hintText,


          //autofillHints: hintText,

        ));
    //throw UnimplementedError();
  }

}