import 'dart:async';

class CategoryPickerBloc {
  StreamController _controller = StreamController.broadcast();
  List<String> categoriesPicked = [];

  get stream => _controller.stream;

  void add(data) {
    categoriesPicked.add(data);
    _controller.sink.add(categoriesPicked);
  }

  void remove(data) {
    categoriesPicked.remove(data);
    _controller.sink.add(categoriesPicked);
  }

  CategoryPickerBloc() {
    stream.listen((e) => categoriesPicked = e);
  }

  void dispose() {
    _controller.close();
  }
}
