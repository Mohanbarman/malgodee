import 'dart:typed_data';
import 'dart:async';

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

  void clear() {
    this.cachedImageBytes = null;
    this.cachedImagePath = null;
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
