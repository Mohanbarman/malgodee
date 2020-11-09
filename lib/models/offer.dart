import 'dart:typed_data';

import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel {
  String id;
  String title;
  String description;
  Uint8List image;

  fromMap(QueryDocumentSnapshot doc) async {
    this.id = doc['id'];
    this.title = doc['title'];
    this.description = doc['description'];
    this.image = await FirebaseStorageApi.futureFromImagePath(doc['image']);
  }

  toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'image': this.image,
    };
  }
}
