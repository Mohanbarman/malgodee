import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

int MAX_SIZE = 1024 * 1024 * 10;

class FirebaseStorageApi {
  Uint8List imageBytes;

  // ignore: non_constant_identifier_names
  // Get the FUTURE of trending offers based on index
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

  static Stream allOffersStream() {
    return FirebaseFirestore.instance.collection('offers').snapshots();
  }

  static Stream trendingOffersStream() {
    return FirebaseFirestore.instance
        .collection('offers')
        .where('type', isEqualTo: 'trending')
        .snapshots();
  }

  static Stream categoriesStream() {
    return FirebaseFirestore.instance.collection('categories').snapshots();
  }
}
