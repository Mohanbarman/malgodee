import 'dart:async';

class ImagePickBloc {
  StreamController _controller = StreamController();

  get stream => _controller.stream;
  get sink => _controller.sink;

  void dispose() {
    _controller.close();
  }
}
