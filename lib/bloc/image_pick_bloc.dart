import 'dart:async';
import 'package:ShoppingApp/shared/localstorage.dart';

class ImagePickBloc {
  StreamController _controller = StreamController.broadcast();

  get stream => _controller.stream;
  get sink => _controller.sink;

  void dispose() {
    _controller.close();
  }

  ImagePickBloc() {
    _controller.stream.listen((event) async {
      print(await LocalStorage.saveImage(bytes: event, filename: 'photo.png'));
    });
  }
}
