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
    return Map<String, dynamic>.from({
      'title': this.title,
      'description': this.description,
      'image': this.remoteImage,
    });
  }

  toJsonLocal() {
    return Map<String, dynamic>.from({
      'title': this.title,
      'description': this.description,
      'image': this.localImage,
    });
  }
}
