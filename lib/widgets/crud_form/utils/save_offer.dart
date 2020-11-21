import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

Future saveOffer({
  Map<String, dynamic> map,
  BuildContext context,
}) async {
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
    collection: 'offers',
  );

  Navigator.pushReplacementNamed(context, '/');
}
