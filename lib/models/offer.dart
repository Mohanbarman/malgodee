class OfferModel {
  String id;
  String name;
  String description;
  String image;

  OfferModel({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  toJson() {
    return Map<String, dynamic>.from({
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'image': this.image,
    });
  }
}
