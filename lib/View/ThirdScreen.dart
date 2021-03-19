
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ViewModel/ThirdClassViewModel.dart';

ThirdClassViewModel vm;

class ThirdScreenClass extends StatelessWidget{
  static const routeName = '/ThirdScreenClass';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ThirdScreenBody()
    );

    //throw UnimplementedError();
  }

}
///*** body
class ThirdScreenBody extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    return ThirdScreenBodyState();
//    throw UnimplementedError();
  }

}

class ThirdScreenBodyState extends State<ThirdScreenBody>{


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child:SizedBox(
        width: double.infinity,
        height: 500,

        child: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Flexible(

          flex: 2,
          fit: FlexFit.loose,

          child: TextFormField(),),
        Flexible(flex: 17,
          fit: FlexFit.loose,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red,
        ),),
      ],) ,
    ));
   // throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();
    vm=ThirdClassViewModel();
  }

  @override
  void dispose() {
    super.dispose();

  }
}