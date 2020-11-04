import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class FirebaseStorageApi {
  int MAX_SIZE = 1024 * 1024 * 10;
  Uint8List imageBytes;
  List docs = [];

  // ignore: non_constant_identifier_names
  // Get the FUTURE of trending offers based on index
  Future trendingOffersFuture(int index) async {
    await FirebaseFirestore.instance.collection('trending_offers').get().then(
      (value) {
        docs = value.docs.toList();
      },
    );
    return FirebaseStorage.instance
        .ref()
        .child(docs[index]['image'])
        .getData(MAX_SIZE);
  }

  // Get the count of regular offers
  Future regularOffersCount() async {
    int val = await FirebaseFirestore.instance
        .collection('regular_offers')
        .get()
        .then((value) => value.size);
    print(val);
    return val;
  }

  // Get the list of regular offers future
  Future regularOffersFuture() async {
    await FirebaseFirestore.instance
        .collection('regular_offers')
        .get()
        .then((value) {
      docs = value.docs.toList();
    });
    print(docs);
    return docs;
  }
}
