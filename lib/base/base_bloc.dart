import 'dart:async';

import 'package:demo_navigator/data/remote/category_service.dart';
import 'package:demo_navigator/data/remote/user_service.dart';
import 'package:demo_navigator/data/repository/category_repository.dart';
import 'package:demo_navigator/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'base_event.dart';
import 'base_event.dart';
import 'base_event.dart';
import 'base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _progressEventSubject = BehaviorSubject<BaseEvent>();// INITILIZATION  streamController
  Sink<BaseEvent>  get progressEvenSink => _progressEventSubject.sink;// initilizartion list event listener stream input
  Stream<BaseEvent> get progressEventStream => _progressEventSubject.stream;
  StreamController<bool> _loadingStreamController = BehaviorSubject<bool>();
  Stream<bool> get loadingStream => _loadingStreamController.stream;
  Sink<bool> get loadingSink => _loadingStreamController.sink;
  BaseBloc(){
    progressEventStream.listen((event){
      dispatchEvent(event);
    });
  }
  void dispatchEvent(BaseEvent event);
  void setLoadingStatus(){}
  void setErrorStatus(){}
  void setContext(BuildContext context){}
  @mustCallSuper
  dispose(){
    _progressEventSubject.close();
    _loadingStreamController.close();
  }
  preLoadStaticData() {
    CategoryRepository _cateRepo = CategoryRepository(categoryService: CategoryService());
    _cateRepo.getCategories(null);
    UserRepository _userRepo = new UserRepository(userService: UserService());
    _userRepo.getUserInfo(null);
  }
}