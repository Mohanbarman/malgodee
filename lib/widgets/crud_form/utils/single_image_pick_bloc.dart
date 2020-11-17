import 'dart:async';

class SingleImagePickBloc {
  StreamController _controller = StreamController.broadcast();
  String currPath;

  Function(String) get add => _controller.sink.add;
  Stream get stream => _controller.stream;

  SingleImagePickBloc() {
    stream.listen((e) {
      print(e);
      currPath = e;
    });
  }

  void dispose() {
    _controller.close();
  }
}
