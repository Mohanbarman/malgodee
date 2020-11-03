import 'dart:collection';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class FirebaseStorageApi {
  Uint8List imageBytes;

  // ignore: non_constant_identifier_names
  int MAX_SIZE = 1024 * 1024 * 10;
  Stream<QuerySnapshot> trendingOffersFuture(int id) {
    CollectionReference docs =
        FirebaseFirestore.instance.collection('trending_offers');
    return docs.snapshots();
  }
}
