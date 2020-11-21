import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

Future updateDoc({
  Map<String, dynamic> map,
  BuildContext context,
  String collection,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    child: Center(child: CircularProgressIndicator()),
  );

  if (!map['image'].contains('https://')) {
    Uuid uuid = Uuid();
    String filename = '${uuid.v1()}${map['image'].split('.').last}';

    String url = await FirebaseStorageApi.uploadFile(
      file: File(map['image']),
      filename: filename,
    );

    map['image'] = url;
  }

  print(map);

  await FirebaseStorageApi.updateDocument(model: map, collection: collection);
  Navigator.pushNamed(context, '/');
}
