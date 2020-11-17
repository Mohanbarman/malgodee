class OfferModel {
  String id;
  String name;
  String description;
  String remoteImage;
  String localImage;
  String image;

  OfferModel({
    this.id,
    this.name,
    this.description,
    this.remoteImage,
    this.localImage,
    this.image,
  });

  toJson() {
    return Map<String, dynamic>.from({
      'name': this.name,
      'description': this.description,
      'image': this.image,
    });
  }

  toJsonRemote() {
    return Map<String, dynamic>.from({
      'name': this.name,
      'description': this.description,
      'image': this.remoteImage,
    });
  }

  toJsonLocal() {
    return Map<String, dynamic>.from({
      'name': this.name,
      'description': this.description,
      'image': this.localImage,
    });
  }
}
