import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

// ignore: non_constant_identifier_names
int MAX_SIZE = 1024 * 1024 * 5;

class FirebaseStorageApi {
  Uint8List imageBytes;

  static Stream streamOfCollection({
    String collection,
    int limit,
  }) {
    try {
      return limit == null
          ? FirebaseFirestore.instance
              .collection(collection)
              .orderBy('createdAt', descending: false)
              .snapshots()
          : FirebaseFirestore.instance
              .collection(collection)
              .limit(limit + 1)
              .orderBy('createdAt', descending: false)
              .snapshots();
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Stream streamOfCollectionFiltered({
    String collection,
    String field,
    String containsValue,
    String isEqualsTo,
  }) {
    try {
      if (isEqualsTo != null)
        return FirebaseFirestore.instance
            .collection(collection)
            .where(field, isEqualTo: isEqualsTo)
            .get()
            .asStream();

      return FirebaseFirestore.instance
          .collection(collection)
          .where(field, arrayContains: containsValue)
          .get()
          .asStream();
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Stream streamOfCollectionSearch({
    String collection,
    String field,
    String searchQuery,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection(collection)
          .where(
            'name',
            isGreaterThanOrEqualTo: searchQuery,
            isLessThanOrEqualTo:
                searchQuery.substring(0, searchQuery.length - 1) +
                    String.fromCharCode(
                      searchQuery.codeUnitAt(
                            searchQuery.length - 1,
                          ) +
                          1,
                    ),
          )
          .get()
          .asStream();
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<String> uploadFile({File file, String filename}) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(filename);
      final TaskSnapshot uploadTask = await ref.putFile(file);
      String url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return 'Invalid url';
    }
  }

  static updateDocument({Map<String, dynamic> model, String collection}) async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(
        collection,
      );

      model['modifiedAt'] = FieldValue.serverTimestamp();

      await ref.doc(model['id']).update(model);
      return true;
    } catch (e) {
      print(e);
    }
  }

  static Future<String> addData({Map data, String collection}) async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(
        collection,
      );

      data['createdAt'] = FieldValue.serverTimestamp();
      data['modifiedAt'] = FieldValue.serverTimestamp();

      DocumentReference dref = await ref.add(data);
      return dref.path.split('/').last;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future deleteDoc({String id, String collection}) async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection(collection);
      await ref.doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future appendToList({
    String id,
    String collection,
    List data,
    String field,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .update({field: FieldValue.arrayUnion(data)});
      return 1;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future removeFromList({
    String id,
    String collection,
    String field,
    List<String> value,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .update({field: FieldValue.arrayRemove(value)});
      return true;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Stream productsFiltered({Map<String, dynamic> idMap}) {
    try {
      print('idMap : $idMap');
      return FirebaseFirestore.instance
          .collection('products')
          .where('categories', arrayContains: idMap['category'])
          .where('brand', isEqualTo: idMap['brand'])
          .get()
          .asStream();
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Stream streamOfDocument({String collection, String id}) {
    try {
      return FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .get()
          .asStream();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
