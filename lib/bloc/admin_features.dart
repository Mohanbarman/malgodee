import 'dart:async';

class AdminFeatures {
  final _authenticationStatus = StreamController();

  get authStatusStream => _authenticationStatus.stream;
  get authStatusSink => _authenticationStatus.sink;
}
