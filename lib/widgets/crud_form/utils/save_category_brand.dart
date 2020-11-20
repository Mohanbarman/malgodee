import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

enum BrandOrCategory { BRAND, CATEGORY }

Future saveCategoryOrBrand({
  Map<String, dynamic> map,
  BuildContext context,
  String collection,
  String correspondingCollection,
  List correspondingFieldElements,
}) async {
  if (correspondingFieldElements.length < 1) return 0;

  showDialog(
    barrierDismissible: false,
    context: context,
    child: Center(child: CircularProgressIndicator()),
  );

  Uuid uuid = Uuid();
  String filename = '${uuid.v1()}${map['image'].split('.').last}';

  String url = await FirebaseStorageApi.uploadFile(
    file: File(map['image']),
    filename: filename,
  );

  map['image'] = url;

  String id = await FirebaseStorageApi.addData(
    data: map,
    collection: collection,
  );

  correspondingFieldElements.forEach((e) {
    FirebaseStorageApi.appendToList(
      collection: correspondingCollection,
      data: [id],
      field: collection,
      id: e,
    );
  });

  Navigator.pushReplacementNamed(context, '/');
}
