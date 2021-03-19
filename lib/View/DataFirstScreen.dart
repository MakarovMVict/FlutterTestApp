

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/View/main.dart';
import 'package:flutter_app/ViewModel/FloatingAppBarScreenVM.dart';
import 'package:flutter_app/ViewModel/ThirdClassViewModel.dart';

import 'TestScreen.dart';


final scaffoldState=GlobalKey<ScaffoldState>();
FloatingAppBarScreenVM _viewModel;//= FloatingAppBarScreenVM();
TextEditingController controller=TextEditingController();



class DataFirstScreenClass extends StatefulWidget {
  static const routeName = '/DataFirstScreenClass';



  String title="";
  String message="";





  DataFirstScreenClass({
    Key key,
     this.title,
     this.message,
  }) : super(key: key);

  @override
  _DataFirstScreenClassState createState() => _DataFirstScreenClassState();


}

class _DataFirstScreenClassState extends State<DataFirstScreenClass> {





  @override
  Widget build(BuildContext context) {
   // WidgetsBinding.instance.addObserver(this);
    print("**VM onStart!!");

    ///TODO переместить во вьюмодель
    _viewModel= FloatingAppBarScreenVM();
    _viewModel.startListen();//.stream.listen(_viewModel.listFill());
    controller.addListener(() => _viewModel.inputMailText.add(controller.text));
    return BodyData(widget.title,widget.message);
    throw UnimplementedError();
  }


  @override
  void deactivate() {
    print("**VM deactivated!");
  }


  @override
  void didChangeDependencies() {
    print("**VM did changed dependencies!");

  }

  @override
  void reassemble() {
    print("**VM reassemble!");

  }

  @override
  void didUpdateWidget(DataFirstScreenClass oldWidget) {
    print("**VM did updte widget!");
  }

  @override
  void dispose() {//TODO подумать как подписываться на события при переоткрытии страницы
   // WidgetsBinding.instance.removeObserver(this);




    super.dispose();
    print("**VM dispose!");
    _viewModel.dispose();
  }
}

class BodyData extends StatelessWidget{


  String title="";
  String message="";


  BodyData(this.title, this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
       key: scaffoldState,
        //resizeToAvoidBottomPadding: true,

        appBar: AppBar(
          title: Text(title) ,
          backgroundColor: Colors.green,
          // leading: IconButton(
          //         icon: Icon(Icons.chevron_left),
          //         onPressed: (){()=>Navigator.pop(context,false);},
          //       ),
        ),
        body: ScreenColumn(message)
      );

    throw UnimplementedError();
  }
}

class ScreenColumn extends StatelessWidget{
  String message="";


  ScreenColumn(this.message);

  @override
  Widget build(BuildContext context) {
    //return SingleChildScrollView(


        return Container(
      width: double.infinity,
      height: double.infinity,
        child: Column(
      children: [
        Flexible(
          flex: 1,
            child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey,

            child: Text(message),


        )
        ),
        Flexible(
          flex: 4,
            child: MyCustomForm()
        ),
        //BottomSheetClass()



      ],
    ));
    //throw UnimplementedError();
  }
}

class MyCustomForm extends StatefulWidget {





  @override
  MyCustomFormState createState() {

   // floatingAppBarScreenVM.inputMailText.add(controller.text));

    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm>  {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
     return MyContainer();//Container(

  }
}

class MyContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return MyConTainerState();
    //throw UnimplementedError();
  }

}

class MyConTainerState extends State<MyContainer>{

  @override
  void initState() {
    super.initState();
   // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
   // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This routine is invoked when the window metrics have changed.
  @override
  void didChangeMetrics() {
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    bool isVisible = value > 0;
    //print("KEYBOARD VISIBLE: ${isVisible}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.yellow[100],
        child: Form(
            //key: _formKey,
            child: Column(
              children: <Widget>[
            //     TextFormField(
            //     // The validator receives the text that the user has entered.
            //     validator: (value) {
            // if (value.isEmpty) {
            // return 'Please enter some text';
            // }
            // return null;
            // },
            // ),
            StreamBuilder<String>(
            stream: _viewModel.outputErrorText,
              builder: (context, snapshot) {
                return MyTextField(
                    controller,
                    "Email",
                    snapshot.data);
              },
            ),
            StreamBuilder(
                stream: _viewModel.outputIsButtonEnabled,
                builder: (context, snapshot) {
                  print("**snapshot data ${snapshot.data}");
                  return SubmitButton(snapshot.data??false);
                }),
            MyList(),
            FlatButton(onPressed: (){

              _viewModel.reloadData.add(null);//жму чтоб обновить данные в списке

            },
                child: Text("Set list Data"))


        ])
    ));
    //throw UnimplementedError();
  }

}

class MyList extends StatelessWidget{

  //List <String>list=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:_viewModel.setListStream() ,
        builder: (context, snapshot) {
      return StreamBuilder(

          builder:(context,dataelement){
        return    Container(
            height: 100,
            width: double.infinity,
            child:ListView.builder(itemCount: _viewModel.listData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(_viewModel.listData[index]);
                }));
      });
        Container(
        height: 100,
          width: double.infinity,
          child:ListView.builder(itemCount: _viewModel.listData.length,
      itemBuilder: (BuildContext context, int index) {
      return Text(_viewModel.listData[index]);
      }));
    }
    );
    // return ListView.builder(
    //
    //
    // );
    //throw UnimplementedError();
  }

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

class SubmitButton extends StatelessWidget{
  bool isEnabled=false;

  SubmitButton(bool isEnabled){
    print("**createButton! $isEnabled");
    this.isEnabled=isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      pushWithResult(context,TestScreenClass());
      }, child: Text(isEnabled?"true":"false"));
    throw UnimplementedError();
  }

  void pushWithResult(BuildContext context,Widget newScreen){//TODO перенести в VM чтоб подписываться на события при закрытии окна
    Navigator.push(context, MaterialPageRoute(builder: (context) {
    //  _viewModel.dispose();

      return newScreen;
    })
    ).then((result){print("**result is $result");
    //_viewModel= FloatingAppBarScreenVM();
    // _viewModel.startListen();//.stream.listen(_viewModel.listFill());
    // controller.addListener(() => _viewModel.inputMailText.add(controller.text));
    });

    //print("**result is $result");

  }

}
/////**чисто для теста методов старта и финиша в окне
// class TestScreenClass extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(
//       leading: IconButton(icon:Icon(Icons.arrow_back),
//         onPressed:() => Navigator.pop(context, "default result of pop"),),
//     ),
//     body: SingleChildScrollView(
//         child:FractionallySizedBox(
//
//
//           child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children:[
//             Flexible(
//           flex: 1,
//               //  fit: FlexFit.loose,
//           child:Container(
//        // width: double.infinity,
//        // height:double.infinity,
//         color: Colors.yellow,
//               child:  Text("")
//           )),
//             Flexible(
//             flex: 2,
//
//                 fit: FlexFit.loose,
//             child: Container(
//
//               //width: double.infinity,
//               //height:double.infinity,
//               color: Colors.red,
//                 child: Text("")
//             )),
//             Flexible(
//               flex: 10,
//                 fit: FlexFit.loose,
//                 child: Container(
//               //width: double.infinity,
//              // height:double.infinity,
//               color: Colors.teal,
//                 child: Text(""),
//                 ))
//       ]
//     ))));
//
//
//    // throw UnimplementedError();
//   }
//
// }





///***bottomsheet
// class BottomSheetClass extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//      showModalBottomSheet(context: scaffoldState.currentState.context, builder:(context)=>Container(
//        width: double.infinity,
//             height:200,
//             color: Colors.green,
//
//      ));
//     //throw UnimplementedError();
//   }

  //  Widget showModalBottomSheetCustom(Widget widget ){
  //    return Container(
  //      width: double.infinity,
  //      height:200,
  //      color: Colors.green,
  //    );
  // }

//}

