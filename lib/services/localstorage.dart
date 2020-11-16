import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class LocalStorage {
  static Future loadOfferData({dynamic model}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (await exists(id: model.id) == true) {
        return await File(
          json.decode(
            pref.getString(model.id),
          )['image'],
        ).readAsBytes();
      }
      await saveOfferData(model: model);
      return FirebaseStorageApi.futureFromImagePath(model.remoteImage);
    } catch (e) {
      print(e);
    }
  }

  static saveOfferData({dynamic model}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localImagePath = await saveImage(
      bytes: await FirebaseStorageApi.futureFromImagePath(model.remoteImage),
      filename: model.localImage ?? model.remoteImage,
    );
    model.localImage = localImagePath;
    print(model.localImage);
    prefs.setString(model.id, json.encode(model.toJsonLocal()));
  }

  static Future loadData({dynamic model}) async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String appDirPath = dir.path;
      String path = '$appDirPath/${model.image}';
      if (await File(path).exists() == true) {
        return await File(path).readAsBytes();
      }
      Uint8List imageBytes = await FirebaseStorageApi.futureFromImagePath(
        model.image,
      );
      await saveImage(bytes: imageBytes, filename: model.image);

      return imageBytes;
    } catch (e) {
      print(e);
    }
  }

  static Future loadImage(String filename) async {
    try {
      print(filename);
      Directory dir = await getApplicationDocumentsDirectory();
      String appDirPath = dir.path;
      String path = '$appDirPath$filename';
      if (await File(path).exists() == true) {
        print('exists');
        return await File(path).readAsBytes();
      }
      Uint8List imageBytes = await FirebaseStorageApi.futureFromImagePath(
        filename,
      );
      print('$imageBytes');
      await saveImage(bytes: imageBytes, filename: filename);
      return imageBytes;
    } catch (e) {
      print(e);
    }
  }

  static saveImage({Uint8List bytes, String filename}) async {
    print(filename);
    Directory _applicationDir = await getApplicationDocumentsDirectory();
    String _path = _applicationDir.path;
    File _fileRef = File(_path + '/' + filename);
    print(_path + '/' + filename);
    _fileRef.writeAsBytes(bytes);
    return _fileRef.path;
  }

  static exists({String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(id);
  }

  static Future pickImage() {
    return ImagePicker().getImage(source: ImageSource.gallery);
  }
}
