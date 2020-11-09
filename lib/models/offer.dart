import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel {
  String id;
  String title;
  String description;
  String remoteImage;
  String localImage;

  OfferModel({
    this.id,
    this.title,
    this.description,
    this.remoteImage,
    this.localImage,
  });

  toJsonRemote() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'image': this.remoteImage,
    };
  }

  toJsonLocal() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'image': this.localImage,
    };
  }
}
