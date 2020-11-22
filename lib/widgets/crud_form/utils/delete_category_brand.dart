import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:flutter/material.dart';

Future deleteCategoryOrBrand({
  BuildContext context,
  String collection,
  String id,
  String correspondingCollection,
  List correspondingFieldElements,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    child: Center(child: CircularProgressIndicator()),
  );

  print('This ran');
  print('*' * 20);
  print('$correspondingFieldElements, $collection, $id');
  print('*' * 20);

  if (correspondingFieldElements.length > 0) {
    correspondingFieldElements.forEach((e) {
      FirebaseStorageApi.removeFromList(
        collection: correspondingCollection,
        field: collection,
        id: e,
        value: [id],
      );
    });
  }

  await FirebaseStorageApi.deleteDoc(id: id, collection: collection);

  Navigator.pushReplacementNamed(context, '/');
}
