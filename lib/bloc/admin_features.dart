import 'dart:async';

enum UserAuth { isAuthorized, unauthorized }

class AdminAuthorization {
  final _authenticationStatus = StreamController<UserAuth>.broadcast();

  UserAuth initialData = UserAuth.unauthorized;
  Stream<UserAuth> get authStatusStream => _authenticationStatus.stream;
  Sink<UserAuth> get authStatusSink => _authenticationStatus.sink;

  AdminAuthorization() {
    authStatusStream.listen((d) {
      this.initialData = d;
    });
  }

  void dispose() {
    _authenticationStatus.close();
  }
}

AdminAuthorization adminStreamController = AdminAuthorization();
