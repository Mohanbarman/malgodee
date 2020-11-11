import 'package:shared_preferences/shared_preferences.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ShoppingApp/models/offer.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class LocalStorage {
  static Future loadOfferData({OfferModel model}) async {
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
  }

  static saveOfferData({OfferModel model}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localImagePath = await saveImage(
      bytes: await FirebaseStorageApi.futureFromImagePath(model.remoteImage),
      filename: model.localImage ?? model.remoteImage,
    );
    model.localImage = localImagePath;
    print(model.localImage);
    prefs.setString(model.id, json.encode(model.toJsonLocal()));
  }

  static saveImage({Uint8List bytes, String filename}) async {
    print(filename);
    Directory _applicationDir = await getApplicationDocumentsDirectory();
    String _path = _applicationDir.path;
    File _fileRef = File(_path + '/' + filename);

    _fileRef.writeAsBytes(bytes);
    return _fileRef.path;
  }

  static exists({String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(id);
  }
}
