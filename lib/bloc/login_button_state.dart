import 'dart:async';

enum ButtonState { isActive, isLoading }

class LoginButtonState {
  final StreamController _loginBtnController = StreamController.broadcast();

  Stream get loginBtnStream => _loginBtnController.stream;
  Sink get loginBtnSink => _loginBtnController.sink;

  void dispose() {
    _loginBtnController.close();
  }
}

LoginButtonState loginButtonState = LoginButtonState();
