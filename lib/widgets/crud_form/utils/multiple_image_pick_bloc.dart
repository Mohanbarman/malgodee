import 'dart:async';

class MultipleImagePickBloc {
  StreamController _controller = StreamController.broadcast();
  List<String> paths = [];

  Function get add => _controller.sink.add;
  Stream get stream => _controller.stream;

  MultipleImagePickBloc() {
    stream.listen((e) {
      if (e is bool) {
        return 0;
      }
      paths.add(e);
    });
  }

  void remove(String path) {
    paths.remove(path);
  }

  void dispose() {
    _controller.close();
  }
}
