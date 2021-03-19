
import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/Pojo/Album.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;


//TODO посмотреть по ссылке ниже как отслеживать жизненный цикл окошек
// https://stackoverflow.com/questions/50131598/how-to-handle-app-lifecycle-with-flutter-on-android-and-ios
///
/// ***ОБъяснение !!!!!!!
///  //textController - это StreamController<String>, типа как Subject
///    textController: Stream - отправляет данные во вью при вызове у него .add
///     Sink - получает данные из вью
///     что касается RX то там всё тоже но PublishSubject вместо StreamController
// /
///

abstract class SubscriptionViewModel {
  Sink get inputMailText;
  Stream<bool> get outputIsButtonEnabled;
  Stream<String> get outputErrorText;

  void dispose();
}



class FloatingAppBarScreenVM implements SubscriptionViewModel{
  CompositeSubscription compositeSubscription=CompositeSubscription();


   List<String> listData=["w","e"];//List.filled(10,"someData" );

   var _textController = StreamController<String>.broadcast();
   var _secondListController=PublishSubject<String>();

   void listFill(String string){
     print("**listFill called! $string");
     //listData.clear();


     // for(int i=0;i<10;i++){
     //   listData.add("value is a ${i+1}");
     // }//TODO тут из сети получить массив и отобразить его
     // _albumNamesLoader.listen((event) {listFillFromInternet(event); });//подписываюсь на событие загрузки
     fetchAlbum();//делаю запрос к сети и если он успешный,то список во вью заполняется

     //onPressedStream.add(null);//вызываю команду обновить лист на экране
   }
   void listFillFromInternet(Album album){
     print("**listFilledFromInternet!");
     listData.add(album.title);
     onPressedStream().add(null);
   }
   ///**for list component
   Stream  setListStream() {
     return _secondListController.stream;
   }//отправляю данные в листвью
   Sink onPressedStream() {
     return _secondListController.sink;
   }//получаю команду для действия(вызывается при нажатии кнопки)

   StreamController _actionController = StreamController();
   StreamSink get reloadData => _actionController.sink;//получаю событие для перезагрузки по нажатии кнопки


   void startListen(){//TODO внести в конструктор вьюмодели а не вызывать при создании виджета!!!!!!
     _actionController.stream.listen((data)=>listFill(data));//слушаю события нажатия кнопки
     StreamSubscription loader=_albumNamesLoader.listen((event) {listFillFromInternet(event); });
     compositeSubscription.add(loader);

     // и перезаполняю список по нажатии
   }




   ///


  @override
  void dispose() {
    // TODO: implement dispose
    // print("**VM dispose!");
    _textController.close();
    _secondListController.close();

    //_albumNamesLoader.close();
    compositeSubscription.dispose();
    _actionController.close();


    //setListStream();

    compositeSubscription=CompositeSubscription();
    //outputIsButtonEnabled=_textController.stream;
    _textController=StreamController<String>.broadcast();
    _albumNamesLoader= PublishSubject<Album>();
    _actionController= StreamController();
    _secondListController=PublishSubject<String>();


    //_albumNamesLoader= PublishSubject<Album>();


    // setListStream
  }

  @override
  // TODO: implement inputMailText
  Sink get inputMailText=>_textController;
   //=> throw UnimplementedError();

  @override
  // TODO: implement outputErrorText
  Stream<String> get outputErrorText =>outputIsButtonEnabled
      .map((isEnabled) => isEnabled ? null : "Invalid email"); //throw UnimplementedError();



  @override
  // TODO: implement outputIsButtonEnabled
  Stream<bool> get outputIsButtonEnabled => _textController.stream
      .map((email) => isEmailValid(email));//шлю изменение текста кнопки каждый раз при изменении текста в поле

  bool isEmailValid(String email){
    if(email=="1"){
      print("**email is CORRECT!");
      return true;
    }else{
      print("**email is NOT CORRECT!");

      return false;
    }
  }
  ///***for http request TODO перенести это в слой модели!!!!

   var _albumNamesLoader = PublishSubject<Album>();
       // .
       // doOnListen(() {print("**Listen from internet!");}).
       // doOnDone(() {print("**from internrt on done!");}).
       // doOnData((event) {print("**from internrt on data!$event");}).
       // doOnError((error){print("**error from internet is $error");}).
       // listen((event) {print("listen");});


   Observable<Album> get setListDataFromInternet=>_albumNamesLoader.stream;
   // fetchAlbum() async{
   //   Album album ;//= await _repository.userInfo();
   //   _albumNamesLoader.sink.add(album);
   // }

   fetchAlbum() async {
     final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

     if (response.statusCode == 200) {
       print("**got http 200!");
       // If the server did return a 200 OK response,
       // then parse the JSON.
       Album album= Album.fromJson(jsonDecode(response.body));
       _albumNamesLoader.sink.add(album);
       for(int i=0;i<listData.length;i++){
         print("**list is $i and ${listData[i]}");
       }
     } else {
       print("**got http error!!!");

       // If the server did not return a 200 OK response,
       // then throw an exception.
       throw Exception('Failed to load album');
     }
   }



}

