import 'dart:async';

class MultipleImagePickBloc {
  StreamController _controller = StreamController.broadcast();
  List<String> currPaths = [];

  Function(String) get add => _controller.sink.add;
  Stream get stream => _controller.stream;

  MultipleImagePickBloc() {
    stream.listen((e) {
      currPaths.add(e);
    });
  }

  void dispose() {
    _controller.close();
  }
}
