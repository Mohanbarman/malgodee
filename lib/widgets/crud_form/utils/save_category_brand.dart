import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/utils/generate_filename_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future saveCategoryOrBrand({
  Map<String, dynamic> map,
  BuildContext context,
  String collection,
  String correspondingCollection,
  List correspondingFieldElements,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    child: Center(child: CircularProgressIndicator()),
  );

  String url = await FirebaseStorageApi.uploadFile(
    file: File(map['image']),
    filename: generateFilename(map['image']),
  );

  map['image'] = url;

  String id = await FirebaseStorageApi.addData(
    data: map,
    collection: collection,
  );

  if (correspondingFieldElements.length > 0) {
    correspondingFieldElements.forEach((e) {
      FirebaseStorageApi.appendToList(
        collection: correspondingCollection,
        data: [id],
        field: collection,
        id: e,
      );
    });
  }

  Navigator.pushReplacementNamed(context, '/');
}
