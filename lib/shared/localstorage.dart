import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:ShoppingApp/models/offer.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future loadData({OfferModel model}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (await exists(id: model.id) == true) {
      return await File(
        json.decode(
          pref.getString(model.id),
        )['image'],
      ).readAsBytes();
    }
    await saveData(model: model);
    return FirebaseStorageApi.futureFromImagePath(model.remoteImage);
  }

  static saveData({dynamic model}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localImagePath = await saveImage(
      bytes: await FirebaseStorageApi.futureFromImagePath(model.remoteImage),
      filename: '${model.id}.png',
    );
    print('Image saved to $localImagePath');
    model.localImage = localImagePath;
    print(model.localImage);
    prefs.setString(model.id, json.encode(model.toJsonLocal()));
    print('Offer saved with key ${model.id}');
  }

  static saveImage({Uint8List bytes, String filename}) async {
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
