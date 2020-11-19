import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

void save({
  Map<String, dynamic> map,
  BuildContext context,
  String collection,
  String correspondingCollection,
  List correspondingFieldElements,
  String correspondingFieldName,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    child: Center(
      child: CircularProgressIndicator(
        semanticsLabel: 'Adding category',
      ),
    ),
  );

  Uuid uuid = Uuid();
  String filename = '${uuid.v1()}${map['image'].split('.').last}';

  String url = await FirebaseStorageApi.uploadFile(
    file: File(map['image']),
    filename: filename,
  );

  map['image'] = url;

  await FirebaseStorageApi.addData(
    data: map,
    collection: collection,
  );

  correspondingFieldElements.forEach((e) {
    FirebaseStorageApi.appendToList(
      collection: correspondingCollection,
      data: map['id'],
      field: correspondingFieldName,
      id: e,
    );
  });

  Navigator.pushNamed(context, '/');
}
