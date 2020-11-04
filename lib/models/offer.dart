class OfferModel {
  String id;
  String title;
  String description;
  String image;

  OfferModel.fromMap(Map doc)
      : id = doc['id'],
        title = doc['title'],
        description = doc['description'],
        image = doc['image'];

  toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'image': this.image,
    };
  }
}
