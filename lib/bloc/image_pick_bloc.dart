import 'dart:async';
import 'dart:typed_data';

class ImagePickBloc {
  Uint8List cachedImageBytes;
  String cachedImagePath;

  StreamController _imageBytesController = StreamController.broadcast();
  StreamController _imagePathController = StreamController.broadcast();

  get imageBytesStream => _imageBytesController.stream;
  get imageBytesSink => _imageBytesController.sink;

  get imagePathStream => _imagePathController.stream;
  get imagePathSink => _imagePathController.sink;

  void dispose() {
    _imageBytesController.close();
    _imagePathController.close();
  }

  ImagePickBloc() {
    _imageBytesController.stream.listen(
      (event) async {
        cachedImageBytes = event;
      },
    );
    _imagePathController.stream.listen(
      (event) async {
        cachedImagePath = event;
        print(event);
      },
    );
  }
}

ImagePickBloc pickedImageBloc = ImagePickBloc();
