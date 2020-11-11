import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

// ignore: non_constant_identifier_names
int MAX_SIZE = 1024 * 1024 * 5;

class FirebaseStorageApi {
  Uint8List imageBytes;

  // ignore: non_constant_identifier_names
  Future trendingOffersFuture(int index) async {
    var x = await FirebaseFirestore.instance
        .collection('offers')
        .where('type', isEqualTo: 'trending')
        .get();
    List docs = x.docs.toList();
    return FirebaseStorage.instance
        .ref()
        .child(docs[index]['image'])
        .getData(MAX_SIZE);
    // return null;
  }

  static Future futureFromImagePath(String path) {
    return FirebaseStorage.instance.ref().child(path).getData(MAX_SIZE);
  }

  // Get the list of regular offers future
  static Future<List> regularOffersFuture(int index) async {
    var value = await FirebaseFirestore.instance.collection('offers').get();
    List docs = value.docs.toList();
    return FirebaseStorage.instance
        .ref()
        .child(docs[index]['image'])
        .getData(MAX_SIZE);
  }

  static Stream allOffersStream({int limit}) {
    return limit == null
        ? FirebaseFirestore.instance.collection('offers').snapshots()
        : FirebaseFirestore.instance
            .collection('offers')
            .limit(limit)
            .snapshots();
  }

  static Stream trendingOffersStream() {
    return FirebaseFirestore.instance
        .collection('offers')
        .where('type', isEqualTo: 'trending')
        .snapshots();
  }

  static Stream streamOfCollection({
    String collection,
    int limit,
    String where,
    String isEqualsTo,
  }) =>
      limit == null
          ? FirebaseFirestore.instance.collection(collection).snapshots()
          : FirebaseFirestore.instance
              .collection(collection)
              .limit(limit + 1)
              .snapshots();

  static Stream streamOfCollectionFiltered({
    String collection,
    int limit,
    String where,
    String isEqualsTo,
  }) =>
      limit == null
          ? FirebaseFirestore.instance.collection(collection).snapshots()
          : FirebaseFirestore.instance
              .collection(collection)
              .where('type', isEqualTo: 'whatsapp')
              .limit(limit + 1)
              .snapshots();

  static updateDocument({model, String collection}) {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    ref.doc(model.id).update(model.toJson());
  }

  static Future<void> uploadFile({File file, String filename}) async {
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    final StorageUploadTask uploadTask = ref.putFile(file);
    await uploadTask.onComplete;
    print('successfully uploaded to $filename');
    return filename;
  }

  static Future<void> addData({Map data, String collection}) async {
    print(data);
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    ref.add(data);
  }

  static deleteDoc({String id, String collection}) async {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    await ref.doc(id).delete();
  }
}
