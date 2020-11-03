class OfferModel {
  String id;
  String title;
  String description;

  OfferModel.fromMap(Map doc)
      : id = doc['id'],
        title = doc['title'],
        description = doc['description'];

  toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
    };
  }
}
