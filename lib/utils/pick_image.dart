import 'package:image_picker/image_picker.dart';

Future<String> pickImage() async {
  final picker = ImagePicker();

  PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
  return pickedFile.path;
}
