import 'dart:async';

class PhoneNumberFieldBloc {
  StreamController _controller = StreamController.broadcast();

  updateText(String text) {
    if (text == null || text == "") {
      _controller.sink.addError("Invalid number entered");
    } else if (text.length < 10) {
      _controller.sink.addError("Number must contain 10 digits");
    } else {
      try {
        int.parse(text);
        _controller.sink.add(text);
      } on FormatException {
        _controller.sink.addError("Only numbers allowed");
      }
    }
  }

  Stream get textStream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
