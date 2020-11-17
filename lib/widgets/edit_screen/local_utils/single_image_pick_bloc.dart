import 'dart:async';

class SingleImagePickBloc {
  StreamController _controller = StreamController();

  Function(String) get add => _controller.sink.add;
  Stream get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
