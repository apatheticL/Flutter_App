import 'dart:async';

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

}