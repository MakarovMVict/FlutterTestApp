

import 'package:flutter_app/Architecture/ViewModel.dart';
import 'package:flutter_app/Model/TestScreenModel.dart';
import 'package:rxdart/rxdart.dart';

class TestScreenViewModel extends ViewModel{

  TestScreenModel testScreenModel=TestScreenModel();

  CompositeSubscription compositeSubscription=CompositeSubscription();



  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void startListen() {
    // TODO: implement startListen
  }


}