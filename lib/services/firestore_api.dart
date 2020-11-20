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
    String where,
    String isEqualsTo,
  }) {
    try {
      return limit == null
          ? FirebaseFirestore.instance.collection(collection).snapshots()
          : FirebaseFirestore.instance
              .collection(collection)
              .limit(limit + 1)
              .snapshots();
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Stream streamOfCollectionFiltered({
    String collection,
    int limit,
    String where,
    String isEqualsTo,
  }) {
    try {
      return limit == null
          ? FirebaseFirestore.instance.collection(collection).snapshots()
          : FirebaseFirestore.instance
              .collection(collection)
              .where(where, isEqualTo: isEqualsTo)
              .limit(limit + 1)
              .snapshots();
    } catch (e) {
      print(e);
      return e;
    }
  }

  static updateDocument({Map<String, dynamic> model, String collection}) async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(
        collection,
      );
      print(model);
      await ref.doc(model['id']).update(model);
      return true;
    } catch (e) {
      print(e);
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

  static Future<String> addData({Map data, String collection}) async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(
        collection,
      );
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
}
