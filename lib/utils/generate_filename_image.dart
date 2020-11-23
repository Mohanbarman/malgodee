import 'package:uuid/uuid.dart';

String generateFilename(String prevFilename) {
  Uuid uuid = Uuid();
  String filename = '${uuid.v1()}${prevFilename.split('.').last}';
  return filename;
}
