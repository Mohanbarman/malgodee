class BrandModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final List categories;

  BrandModel({
    this.name,
    this.description,
    this.image,
    this.id,
    this.categories,
  });

  toJson() {
    return Map<String, dynamic>.from({
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'image': this.image,
      'caegories': this.categories,
    });
  }
}
