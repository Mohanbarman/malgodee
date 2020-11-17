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
              .where('type', isEqualTo: 'whatsapp')
              .limit(limit + 1)
              .snapshots();
    } catch (e) {
      print(e);
      return e;
    }
  }

  static updateDocument({model, String collection}) {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection(collection);
      ref.doc(model.id).update(model.toJson());
    } catch (e) {
      print(e);
    }
  }

  static Future<String> uploadFile({File file, String filename}) async {
    try {
      StorageReference ref = FirebaseStorage.instance.ref().child(filename);
      final StorageUploadTask uploadTask = ref.putFile(file);
      StorageTaskSnapshot value = await uploadTask.onComplete;
      String url = await value.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return 'Invalid url';
    }
  }

  static Future<void> addData({Map data, String collection}) async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection(collection);
      ref.add(data);
      return 1;
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
    } catch (e) {
      print(e);
      return e;
    }
  }
}
